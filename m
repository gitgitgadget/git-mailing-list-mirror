From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: [BUG] git-send-email format-patch awareness & retry
Date: Tue, 7 Sep 2010 16:59:43 +0000
Message-ID: <AANLkTimtOguHdcs+QYj7ePNeyMNsWYLDu+yfyOPrDWUG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ryan Anderson <ryan@michonline.com>, Greg KH <greg@kroah.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 07 19:01:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot1YS-0001pF-Rf
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 19:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361Ab0IGQ7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 12:59:49 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57257 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932358Ab0IGQ7p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 12:59:45 -0400
Received: by fxm16 with SMTP id 16so118162fxm.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 09:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=4rKiYDVZIJcJZ7PL/T5kTJDUrO09KWZ++DEK4ceO78c=;
        b=jjbH4OqfjzKx4mbtYHLMcgvnUMAmyARQevQ5BdlfOJ07jA8dF/na5h2FdaJHFbNbTO
         LZ+mmTDRJjfp5BwDJ1zFPUHiDaQ/2fGYI9E8R5n2suGQxRW/UQLh1gMdokDUAwDLCUfx
         U6p9ADdP5KKdr+VSXo/cQMxGJCpjrIf+ZdoeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=wv9BoCRvi3TUc47kflivVAVfVB5W8Em5JZ9leymTxnsZAUMf9ugUf7+2HPs/F5igmW
         Gr2FWNNpYX4Jvqdah6oFN+tj0bAW3jOPMxOHYpbmirhwMntJXgZKLMU0ioncGzzntAAb
         aDBJ269PMpuIe/7iXHrYxTh4no/uRCM8BryqE=
Received: by 10.223.126.19 with SMTP id a19mr232334fas.88.1283878784132; Tue,
 07 Sep 2010 09:59:44 -0700 (PDT)
Received: by 10.223.120.14 with HTTP; Tue, 7 Sep 2010 09:59:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155729>

(cc primary authors & Junio)

This is more of a TODO note to myself than a bug, but if someone else
gets around to fixing these that'd be great too.

git-send-email should:

 * Complain loudly on "*** SUBJECT HERE ***" and "*** BLURB HERE ***"

   This should have an additional "are you sure" dialog:

    Subject: [PATCH 00/20] *** SUBJECT HERE ***
    Date: Tue,  7 Sep 2010 16:43:03 +0000
    Message-Id: <1283877803-17757-1-git-send-email-avarab@gmail.com>
    X-Mailer: git-send-email 1.7.2.3.313.gcd15
    MIME-Version: 1.0
    Content-Type: text/plain; charset=UTF-8
    Content-Transfer-Encoding: 8bit

    Send this email? ([y]es|[n]o|[q]uit|[a]ll): y
    Password:

 * Retry before bailing out:

   It's annoying to lose state because of temporary SMTP errors. This
   should offer to sleep for a few seconds and retry:

    Content-Transfer-Encoding: 8bit

    Send this email? ([y]es|[n]o|[q]uit|[a]ll): y
     Go ahead k83sm4304468weq.14
    4.3.0 Mail server temporarily rejected message. k83sm4304468weq.14

It would also be a lot easier to catch errors in the git-send-email
output if it supported colors, e.g. colored the subject line
differently from others.
