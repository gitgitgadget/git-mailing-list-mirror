From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATH/RFC] parse-options: report invalid UTF-8 switches
Date: Mon, 11 Feb 2013 18:15:19 +0100
Message-ID: <CABPQNSYoS6ik-29HSy14P69n7zJQORDT9Pa2O1BO=hL3wDuTeA@mail.gmail.com>
References: <1360589687-9233-1-git-send-email-kusmabite@gmail.com> <7v7gmeok2e.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 18:16:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4wzV-00081Y-GI
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 18:16:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758185Ab3BKRQD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 12:16:03 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:56816 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757740Ab3BKRQC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 12:16:02 -0500
Received: by mail-ie0-f176.google.com with SMTP id k13so7857640iea.35
        for <git@vger.kernel.org>; Mon, 11 Feb 2013 09:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=IBbSuTR+le4LzpHttd6RlNOj7Usk6meu4APpEYZ8knw=;
        b=Lk96eJl7p+wav+9L1VbuFonrPcQG6PxIDkFmRnZwYHQWhstaWW9hXpY+EkoBHp+Fcv
         G43wSpviRUdqEyTPTixRjDrbMXwDj4oe8NeWCpFUAeoavBK0vmQLqQBXMWbzObVueDUE
         vipULHF1x8Mdu9NsLccx8pR69PHRSnbzR2t5ZQ2NUIFJvI1qNQugcGSxUnItKl6Jd8fO
         2P3kId2Q/NUDgyElQunyPUDV/e4Bfb45JwyLt5tgvZoywIsCEBET/o8k9RGoKjWcepza
         SCje3d6vIXJoG6Ge21dztJflpvCEMFa3xLtQVB2eTzbn8sExc3GERPvzkVcahQNn5dx7
         YisQ==
X-Received: by 10.50.151.176 with SMTP id ur16mr12977947igb.30.1360602960043;
 Mon, 11 Feb 2013 09:16:00 -0800 (PST)
Received: by 10.64.164.139 with HTTP; Mon, 11 Feb 2013 09:15:19 -0800 (PST)
In-Reply-To: <7v7gmeok2e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216058>

On Mon, Feb 11, 2013 at 6:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> However, since git only looks at one byte at the time for
>> short-options, it ends up reporting a partial UTF-8 sequence
>> in such cases, leading to corruption of the output.
>
> Isn't it a workable, easier and more robust alternative to punt and
> use the entire ctx.argv[0] as unrecognized?
>

Perhaps. It doesn't match the output of the usual GNU tools like we
currently do, but even the GNU tools only report a single byte.

However, I'm unsure if that totals to an improvement in the common
case. We stop telling the user exactly what option was problematic,
making it slightly more annoying to read through the options.

So, we'd end up making the common-case worse, by making a special case
(that only sometimes affects some users) more robust. Isn't that
making the user interface worse?
