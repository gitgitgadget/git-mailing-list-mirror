From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] stash: copy the index using --index-output instead of cp -p
Date: Tue, 15 Mar 2011 20:53:08 +0100
Message-ID: <AANLkTi=+-tDz6XSSUAyvzGZ6fJohSU+rY4GhRa5C-+oA@mail.gmail.com>
References: <4D7F3AA4.1080202@elegosoft.com>
	<4D7F466A.4090508@viscovery.net>
	<4D7F54C2.5060500@elegosoft.com>
	<4D7F5DA0.3030608@viscovery.net>
	<7vk4g09o9x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jakob Pfender <jpfender@elegosoft.com>, git@vger.kernel.org,
	casey@nrlssc.navy.mil, jon.seymour@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 20:53:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzaIu-0004X5-FZ
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 20:53:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212Ab1COTxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 15:53:11 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57735 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757833Ab1COTxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 15:53:09 -0400
Received: by wya21 with SMTP id 21so912891wya.19
        for <git@vger.kernel.org>; Tue, 15 Mar 2011 12:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=tCbY63uFxEy6CzY6Ea9zRWmR2URBw6ykO2rcGjls+j4=;
        b=TxLikKdO1Xy1qrHwDD+mVJAqZF+FlmrFcTxl2yNAovRaMzjlMm5wpS/ifIxBvDPzLr
         Qd4qpj1jc/cA9lckR8HTmVktX7FkTevqY3U/Y+EbHl24xxaGV3zqaZNwzOb8FFP5RxhC
         QKOufW86njif3K+yL/+EZ/y2/tPjO1I4niO4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=sVJeieY66MhYmUn9EM5HJ2qTST8oSfJow9Ekn5/ZscGR0GMsk9AAENOvBQ0GKR+u82
         zt2iaio5Xpu/sMV+lDO7wrDb8C0uAUFXGveDzM5nE3VfZIrNaYTKq3hUR/S7XocfhffH
         B//u8j2wGlmSkKybWaZizroKlSepk439A2n5k=
Received: by 10.227.150.151 with SMTP id y23mr12939187wbv.135.1300218788197;
 Tue, 15 Mar 2011 12:53:08 -0700 (PDT)
Received: by 10.227.135.67 with HTTP; Tue, 15 Mar 2011 12:53:08 -0700 (PDT)
In-Reply-To: <7vk4g09o9x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169088>

On Tue, Mar 15, 2011 at 20:28, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Sixt <j.sixt@viscovery.net> writes:
>
>> Luckily, the first operation in git-stash after copying the index is to
>> call 'git read-tree'. Therefore, use --index-output instead of 'cp -p'
>> to write the copy of the index.
>
> Thanks, will apply.

Please note that the file to the --index-output option needs to be on
the same filesystem as GIT_INDEX_FILE, so that it can be renamed. Here
is the corresponding manual page paragraph for this:

       --index-output=<file>
           Instead of writing the results out to $GIT_INDEX_FILE, write the
           resulting index in the named file. While the command is operating,
           the original index file is locked with the same mechanism as usual.
           The file must allow to be rename(2)ed into from a temporary file
           that is created next to the usual index file; typically this means
           it needs to be on the same filesystem as the index file itself, and
           you need write permission to the directories the index file and
           index output file are located in.

I don' have the full context, so I can't judge whether $TMP-index is
guaranteed to be on the same filesystem as
${GIT_INDEX_FILE-"$GIT_DIR/index"}.

Bert
