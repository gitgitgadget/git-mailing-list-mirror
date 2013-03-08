From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: [PATCH] setup.c: Fix prefix_pathspec from looping pass end of
 string
Date: Thu, 07 Mar 2013 20:58:34 -0500
Message-ID: <513945CA.6070302@gmail.com>
References: <1362674163-24682-1-git-send-email-andrew.kw.w@gmail.com> <7vobeulw4d.fsf@alter.siamese.dyndns.org> <CADgNjakrBCD2jMNUz95E-7FkyKmNgcQeuz8grDWczb-hM6yHhg@mail.gmail.com> <7vvc92kbho.fsf@alter.siamese.dyndns.org> <CADgNja=8f+_ORb_WStRz2grr0pYmJ2gZTnCHbOGUb3ogPPd_LQ@mail.gmail.com> <7vk3pik6aq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 08 03:03:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDmev-0001UB-EP
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 03:03:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760164Ab3CHCDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 21:03:19 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:61614 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759329Ab3CHCDT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 21:03:19 -0500
Received: by mail-ie0-f175.google.com with SMTP id c12so1456450ieb.34
        for <git@vger.kernel.org>; Thu, 07 Mar 2013 18:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=RwGH0EwOZV8Gf0suocHef4vPLgcKd1+c5/tM6iIX4WI=;
        b=thMVfIeFzeD73Yqlsf8fDPnbBlNLWT7PlOKZwNz/tBVB1OKK5+QsX2i8KBjVtZh8VC
         YJYlq2f0rsTmHb13XfqI15tYODMhIV4FlH0YQZvCvWDcigahHxUyfgsadKQCouPtvlLf
         hgyun7I2+xicTLg5n6h00q1ePtFCSMNWqRzz+krtqD41VP6cII95mHnV3nVbct1T1m1r
         PW996q3ho3UPW07Y6FNMQuTDwBv16UBwD4LaE6xUqAFVi5fs+mTDxJcwVQnbHuzJQS6T
         Lyv9U2YvlWeRVfcHzvKNggdGJAnVklgJpbS8BE5EiS/KvBnPsBhOGoU5apYU6WNEWUJ5
         Trgg==
X-Received: by 10.50.183.233 with SMTP id ep9mr16562214igc.87.1362708198630;
        Thu, 07 Mar 2013 18:03:18 -0800 (PST)
Received: from [192.168.1.4] ([69.165.234.69])
        by mx.google.com with ESMTPS id xf4sm29287307igb.8.2013.03.07.18.03.17
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Mar 2013 18:03:17 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.11) Gecko/20121202 Thunderbird/10.0.11
In-Reply-To: <7vk3pik6aq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217636>

On 03/07/13 20:51, Junio C Hamano wrote:
> But it is equally broken to behave as if there is nothing wrong in
> the incomplete magic ":(top" that is not closed, isn't it?
Ah, yea, I did notice that, but then I saw a few lines below:
        if (*copyfrom == ')')
            copyfrom++;
which is explicitly making the ")" optional. So I thought maybe that was
the original intention, and left it at that. Though the doc says to end
with ")", so I guess it should error out after all? If that's the case,
I can try to come up with a patch to error it out (through die() ?).
