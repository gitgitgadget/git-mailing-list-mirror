From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH 0/2] git-p4: fix for handling of multiple depot paths
Date: Wed, 16 Dec 2015 07:51:39 +0000
Message-ID: <5671180B.9010008@diamand.org>
References: <1450037234-15344-1-git-send-email-luke@diamand.org> <CAE5ih7_T1xC9AyO41T4ktJmj6tENaEGbAG556WLyfsYz-jawsw@mail.gmail.com> <xmqqio40kfhl.fsf@gitster.mtv.corp.google.com> <CAE5ih7_9m8kw=sVj8Sv5mAfT_22-g0vdTb78FvLTrNUkJO0M0g@mail.gmail.com> <xmqqtwnkhegw.fsf@gitster.mtv.corp.google.com> <CAE5ih7_qY5oF+UWs4gE2eHUu17pBg6TVGTUyRRRcBe12ybkw+Q@mail.gmail.com> <1450220213834.32062@vmware.com> <20151216003834.GG48528@hocevar.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Users <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Sam Hocevar <sam@hocevar.net>, James Farwell <jfarwell@vmware.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 08:51:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a96sB-0000zl-7B
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 08:51:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965515AbbLPHvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 02:51:38 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34298 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933816AbbLPHvf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 02:51:35 -0500
Received: by mail-pa0-f46.google.com with SMTP id wq6so19556971pac.1
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 23:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=XjPocj0+vmIhBmx1l4hSyhPAzRi+BX9WLgjK/CqdRss=;
        b=DIQvYFf//5a9J9E6rcrb6qlGz/MGWmt1c7pZj2eOVEbsfMIxFJxGgN8g9QYm5mT8gS
         +mbzNxp1KoKzkZiU8LqyuFEO6gbUPa3ksxflrNTJcqZo2OZXNHdQX2hFjqjBgUbYhPxG
         +0HfJPcadC6ubBV/WOayU2oDuNoZcWU9Y56xI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=XjPocj0+vmIhBmx1l4hSyhPAzRi+BX9WLgjK/CqdRss=;
        b=SqGtuuqENr83FDVDiuJfqU9S/b+wbkb4MRyV1sftn1iLFpqc/+51u/7dVfdH3WBGJ2
         k6/MnuWUXJCNdKvE1bkRmwY/j7WtZw40v+aWSuVu/uSDSIzcYTiBVbkL5w39FdWgnCMP
         kLfkW6YKp5dB+rk/V1B0WrxfJ/4DQxTQTCGrsMWMM3DHH1nm9wo161XUE2MQFo6C4hje
         j9I7NeYQrCX9uTe5vFl2TXC8qjPDjQ2APQRYZqVax8wfitsugoQhM9ef4412eCcWeQKh
         yONwodoVIQWi0+JfIUSGZxt5OpWHSbbs6X/Wy1hhYnyKjdpVWbtSNnrlGV2pREjCzrzE
         SA1A==
X-Gm-Message-State: ALoCoQlzgtFH+mXkJTEh9tU3VKR/YPZxuA1Ju7iW/6AgDxKw2k1z+1PaN6v18gj2evb+auRan+rqOx8UUyAqO+z7UQZvOTeGPw==
X-Received: by 10.67.6.195 with SMTP id cw3mr11142564pad.88.1450252294692;
        Tue, 15 Dec 2015 23:51:34 -0800 (PST)
Received: from [192.168.245.128] (cpc12-cmbg17-2-0-cust914.5-4.cable.virginm.net. [86.30.131.147])
        by smtp.gmail.com with ESMTPSA id ux2sm6972724pac.46.2015.12.15.23.51.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Dec 2015 23:51:33 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <20151216003834.GG48528@hocevar.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282541>

On 16/12/15 00:38, Sam Hocevar wrote:
> I'm actually surprised that the patch changes the order at all,
> since all it does is affect the decision (on a yes/no basis) to
> include a given file into a changelist. I'm going to have a look at
> that specific unit test, but of course as a user I'd prefer if the
> default behaviour could remain the same, unless it was actually a
> bug.
>

We ask for changes in
   //depot/sub1/...@1,6
   //depot/sub2/...@1,6'

which gives us [4, 6, 3, 5].

The old code used to sort this list but this change removes the sort.
Maybe putting the sort back would fix it?

> I'm not sure if my opinion as an outsider is of use, but since the
> perforce change number is monotonically increasing, my expectation as
> a user would be for them to be applied in order by the perforce
> change number.

In answer to James' question, the test checks that the most recent
change wins (i.e. applied in order).

Luke
