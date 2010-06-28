From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [PATCH v4 1/3] Avoid conflicts when merging branches with
	mixed normalization
Date: Mon, 28 Jun 2010 10:02:34 +0200
Message-ID: <20100628080234.GA7134@pvv.org>
References: <cover.1277667177.git.eyvind.bernhardsen@gmail.com> <07a766a7972671b9e39dbca55719d024c30c7a28.1277667177.git.eyvind.bernhardsen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 28 10:02:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OT9Iq-0001ov-1p
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 10:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755233Ab0F1ICp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 04:02:45 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:32770 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754602Ab0F1ICn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 04:02:43 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1OT9IY-0004Uu-Ic; Mon, 28 Jun 2010 10:02:34 +0200
Content-Disposition: inline
In-Reply-To: <07a766a7972671b9e39dbca55719d024c30c7a28.1277667177.git.eyvind.bernhardsen@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149819>

> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -317,6 +317,18 @@ command is "cat").
>  	smudge = cat
>  ------------------------
>  
> +For best results, `clean` and `smudge` commands should produce output
> +that is not dependent on the corresponding command having been run.
> +That is, `clean` should produce identical output whether its input has
> +been run through `smudge` or not, and `smudge` should not rely on its
> +input having been run through `clean`.  See the section on merging
> +below for a rationale.

I think this is marginally unclear, what about:

  Clean should not alter its output further if run again
  clean(x) == clean(clean(x))

  Smudge should not alter the output of clean
  clean(x) == clean(smudge(x))

It should not matter that smudge will do something weird if clean
hasn't been run, as long as clean(x) == clean(smudge(x)) still
holds. I also think it is worth mentioning explicitly that clean can
be run multiple times, you should not have to infer this.

> [...]
> +Merging branches with differing checkin/checkout attributes
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Maybe something about when this happens, or even put it in the header
instead? Something like

  If you have added attributes to a file that cause the canonical
  repository format for that file to change, such as adding a
  clean/smudge filter or text/eol/ident attributes, merging anything based
  on a point in time where the attribute was not in place would normally
  cause merge conflicts.

> +
> +To prevent unnecessary merge conflicts, git runs a virtual check-out
> +and check-in of all three stages of a file when resolving a three-way
> +merge.  This prevents changes caused by check-in conversion from
> +causing spurious merge conflicts when a converted file is merged with
> +an unconverted file.


- Finn Arne
