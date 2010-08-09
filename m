From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/5] Turn unpack_trees_options.msgs into an array + enum
Date: Mon, 09 Aug 2010 22:49:35 +0200
Message-ID: <vpq8w4fse8w.fsf@bauges.imag.fr>
References: <1281363602-27856-1-git-send-email-Matthieu.Moy@imag.fr>
	<1281363602-27856-2-git-send-email-Matthieu.Moy@imag.fr>
	<7vwrrz4lgi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 09 22:50:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiZIc-0002ZD-U8
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 22:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754386Ab0HIUuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 16:50:17 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56159 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752842Ab0HIUuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 16:50:16 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o79KlB71010592
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 9 Aug 2010 22:47:11 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OiZHr-00028l-DE; Mon, 09 Aug 2010 22:49:35 +0200
In-Reply-To: <7vwrrz4lgi.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 09 Aug 2010 12\:47\:41 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 09 Aug 2010 22:47:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o79KlB71010592
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1281991636.68068@JcI6sfRtvrSRrv3YrKnsPQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153020>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> The list of error messages was introduced as a structure, but an array
>> indexed over an enum is more flexible, since it allows one to store a
>> type of error message (index in the array) in a variable.
>
> Hmm, the only example of the advantage "enum used as array index" offers
> that I can think of off the top of my head is that you can more easily
> iterate over it.

The portion of my message you cite give another: the ability to store
the index easily in a variable (or to pass it as argument to a
function). With a struct, you can easily pass field name to a macro,
but not to a function.

The other is that you can have multiple arrays indexed over the same
enum, which is what we do later: we'll have to manage an array of list
of rejected paths, with one list per error kind.

(we'll also have to iterate over this second array)

The previous version of the patch serie was using both a struct and an
enum + array, and I wanted to get rid of that.

> If you are to change them to enum, I would actually suggest renaming them
> a bit more to make them stand out.  Perhaps spell them all in caps,
> perhaps have them share the same short prefix (UTEM_ - unpack trees error
> messages), etc.

I'd say just "ERROR_*" (UTEM seems hard to read, and won't be used
often enough for people to remember it), but I'm fine with all caps +
prefix, yes. A quick grep shows this is how the rest of Git does.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
