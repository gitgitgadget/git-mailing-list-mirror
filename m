From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Jun 2010, #04; Wed, 23)
Date: Fri, 25 Jun 2010 08:02:00 +0200
Message-ID: <4C244658.9020704@viscovery.net>
References: <7viq59e6zn.fsf@alter.siamese.dyndns.org> <20100624111757.GB3453@pvv.org> <7veifwchb6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Finn Arne Gangstad <finnag@pvv.org>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 25 08:02:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OS1zZ-0008T0-7J
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 08:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324Ab0FYGCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 02:02:05 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:35943 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825Ab0FYGCE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jun 2010 02:02:04 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OS1zF-00044Y-7C; Fri, 25 Jun 2010 08:02:01 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id E7B5B1660F;
	Fri, 25 Jun 2010 08:02:00 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.10) Gecko/20100512 Thunderbird/3.0.5
In-Reply-To: <7veifwchb6.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149667>

Am 6/24/2010 22:21, schrieb Junio C Hamano:
> Finn Arne Gangstad <finnag@pvv.org> writes:
>> If .gitattributes is different on the different sides, or if you
>> enable autocrlf, the current repo contents may change after
>> git-to-worktree and worktree-to-git again.
> 
> IOW, g2w-then-w2g may not be an identity function.
> 
> If we were to encourage use of this codepath to wider audiences, we may
> need to have a document for people who write smudge/clean filters.  In
> order for the result to be stable, applying g2w-then-w2g once again on top
> of the result of running g2w-then-w2g on anything should be no-op, no?

I think this is implicit to some degree in the documentation,
gitattributes(5):

  The content filtering is done to massage the content into a shape that
  is more convenient for the platform, filesystem, and the user to use.
  [...] the intent is that if someone unsets the filter driver
  definition, or does not have the appropriate filter program, the
  project should still be usable.

>From this I read that the content of the repository can only be in a
canonical shape; hence, the only thing that a clean filter can do is to
generate the canonical shape of the data. This is, by definition, an
idempotent operation (i.e., g2w(g2w(x)) == g2w(x)).

(I'm talking only about clean filters because any pair of smudge+clean
filters where the clean filter cannot undo the effect of the smudge filter
would be noticed immediately and be considered broken without being
mentioned explicitly in the documentation.)

-- Hannes
