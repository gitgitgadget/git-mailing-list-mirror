From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [RFC/PATCHv2] git submodule split
Date: Sat, 14 Feb 2009 10:03:31 +0100
Message-ID: <8c5c35580902140103o3e5dd091qe2a18ca52b6fe44a@mail.gmail.com>
References: <431341160902121350x45076c8cj26afab0b7a51cac5@mail.gmail.com>
	 <1234578258-48870-1-git-send-email-git@randomhacks.net>
	 <7v3aeh3a84.fsf@gitster.siamese.dyndns.org>
	 <431341160902132117s1696c975mbf20dfbdc65a7df3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Ping Yin <pkufranky@gmail.com>
To: Eric Kidd <git@randomhacks.net>
X-From: git-owner@vger.kernel.org Sat Feb 14 10:05:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYGSN-0002Ew-DR
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 10:05:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbZBNJDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 04:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbZBNJDf
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 04:03:35 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:55198 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792AbZBNJDd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 04:03:33 -0500
Received: by fxm13 with SMTP id 13so4265816fxm.13
        for <git@vger.kernel.org>; Sat, 14 Feb 2009 01:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hAQrxmYvc3NxiXDKxqDPARP6oT5/D00Pkfwgx2cxDPE=;
        b=SSS0diG92fT8WeBl++uDplpDQYMKxNJjROBhOYoBEKrE4/db/ckJGDiXkOhugrI6G/
         5LRIJXZVHty17YqtNdAXcD+XzTT6LLMw0I2GGdgsGqB5YjVbq7DzyFzy+cH0ZDW/Y0Xu
         f051jOi6W8HFarKlCMK6ToIytyyND2afdb0Gc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aEywf47xoGYI/GVLibhjIRPSyaSHlfdFh5k0Mlv19ql4+wDJcgL5PYRG6qLx2UluSi
         4a0D0efOc7j+kjg0TOaMIlyVXkYKkYvhVLGh4HdGaNhpxtQtFiWFPC6HwSEJOgcfW3wM
         wMyaHkAs5X82ytVI38b+pYQ9lSwLBovQvWG6Y=
Received: by 10.86.3.4 with SMTP id 4mr208645fgc.66.1234602211397; Sat, 14 Feb 
	2009 01:03:31 -0800 (PST)
In-Reply-To: <431341160902132117s1696c975mbf20dfbdc65a7df3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109846>

On Sat, Feb 14, 2009 at 06:17, Eric Kidd <git@randomhacks.net> wrote:
> On Fri, Feb 13, 2009 at 11:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Kidd <git@randomhacks.net> writes:
>>> ...
>>> If the submodule has moved around the source tree, specify one or more
>>> values for alternate_dir.  To specify the URL of the newly created
>>> repository (for use in .gitmodules), use the --url parameter.
>>
>> Unfortunately, I do not think we have designed fully (nor implemented at
>> all) behaviour to check out different points of history that has the same
>> submodule moved around in the superproject tree.
>>
>> There were several unconcluded discussions done in the past (and I admit I
>> participated in a few of them), but it may be hard to use the resulting
>> repository out of this tool.
>
> Thank you for looking at this proposal!
>
> I think that the resulting repository is usable (though it could
> certainly be better). In particular, the following commands will
> always give you a working checkout:
>
>  git checkout any-version
>  git submodule update --init
>
> The unit tests for git-submodule-split.sh actually walk through the
> entire history and run 'git submodule update --init' at each revision.
> This works correctly because git-submodule-split creates the necessary
> .gitmodules entries for each revision, and includes the
> submodule.*.url value that you specify.
>
> Unfortunately, this means that whenever the submodule moves to a new
> location in the tree, 'git submodule --init' will actually have to
> clone it again. That's not a perfect situation, but it will work for
> reasonably small submodules.

<hand-waving>
I didn't look at the patch, but if the submodule uses a single
module-name while moving around, the re-cloning problem would by
solved if the submodule git-dir was stored inside the git-dir of the
containing repository  (by using the git-file mechanism). Maybe I
should try to finally implement this...
</hand-waving>

--
larsh
