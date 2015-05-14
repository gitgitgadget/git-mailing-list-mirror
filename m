From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Problem with rerere forget
Date: Thu, 14 May 2015 11:49:12 -0700
Message-ID: <xmqq7fsbkn9z.fsf@gitster.dls.corp.google.com>
References: <CAPt1q6fMMz61aZEJB9b+K6+kHFwkm+bMYXoKBj78GNJU+dWioA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Alex Coppens <alex@nativetouch.com>
X-From: git-owner@vger.kernel.org Thu May 14 20:49:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsyC8-00036a-4f
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 20:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933129AbbENStP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 14:49:15 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:32956 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbbENStP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 14:49:15 -0400
Received: by iebgx4 with SMTP id gx4so68366922ieb.0
        for <git@vger.kernel.org>; Thu, 14 May 2015 11:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=F4fO2Ycizy1Bn9C1KjAlkv8r3fWPsOg0Juqy2Vktzy8=;
        b=KX8Oun6zzgLgoligluRo1ZLuQHpIcX4ABonsP0b1ysV19/dJUj1wphvD8jPlt6mjqY
         P5RFvzEVHgFurbBzsAhmAw0wdQiX7yyYZG3zx8ObFljnQCZrXocaRwAwHqM6WCrMrHt8
         6rWQU7vJEXgNPH9rIpqtUe4dZjGjM0X8nKoCvaqZREvXhMJQLclMgIfYoGX51YTKILHN
         5f161pmc6lrlU+1z01fUGDuaep0hwFrr8mF6Au4V0NZ8QkurCmdIfbNPR2btgHGJZX3b
         2UAq36aegRDuHw5BZ0b3vG0MX8wCeA4SWQ7MTikMqjeN/ww9EOUjKbvfHZLQ6efV5UJw
         oVng==
X-Received: by 10.107.128.149 with SMTP id k21mr7179346ioi.7.1431629354453;
        Thu, 14 May 2015 11:49:14 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:74eb:19e4:cd06:a6b6])
        by mx.google.com with ESMTPSA id f7sm6420792igq.7.2015.05.14.11.49.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 14 May 2015 11:49:13 -0700 (PDT)
In-Reply-To: <CAPt1q6fMMz61aZEJB9b+K6+kHFwkm+bMYXoKBj78GNJU+dWioA@mail.gmail.com>
	(Alex Coppens's message of "Thu, 14 May 2015 14:05:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269066>

Alex Coppens <alex@nativetouch.com> writes:

> git rerere forget path_to_file/file.js
>
> fatal: BUG: attempt to commit unlocked object

That comes from commit_lock_file(); I think rerere.c:write_rr()
has a call to that function and I suspect that is the call that is
giving the above message.

Is there any other process that is mucking with your .git/index file
while you are running the command?
