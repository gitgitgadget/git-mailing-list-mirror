From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 06/11] commit: add tests of commit races
Date: Wed, 11 Feb 2015 10:24:35 -0800
Message-ID: <CAGZ79kYFvLWsasWsEevLqugY_Yts5K4e3WRJtKmN4S67F9W6+Q@mail.gmail.com>
References: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>
	<1423412045-15616-7-git-send-email-mhagger@alum.mit.edu>
	<CAGZ79kYmgeXt1k22h3fbDR04BTHOQRxryNVSJDOL2DC5yLLHpw@mail.gmail.com>
	<xmqq1tlxwpgi.fsf@gitster.dls.corp.google.com>
	<54DB6F9C.7060600@alum.mit.edu>
	<xmqqk2zouxnx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 19:24:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLbxp-00008e-85
	for gcvg-git-2@plane.gmane.org; Wed, 11 Feb 2015 19:24:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377AbbBKSYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2015 13:24:37 -0500
Received: from mail-ie0-f182.google.com ([209.85.223.182]:44112 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753755AbbBKSYg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2015 13:24:36 -0500
Received: by iecar1 with SMTP id ar1so6026881iec.11
        for <git@vger.kernel.org>; Wed, 11 Feb 2015 10:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5Dz4XLfBzjqlbbL0ueGli23xTgGd/JPlHwuKsakcNuk=;
        b=VbpJBktOohKVwxn9eTSopnhm60pq5/5esOYJUcc7D+4ZP3OXC6C4YXtJWWeFXSZtKd
         QG7JwvJCDFheB+nZvfgy4v2kUFU63V/RWL8+rFE459VGNIbuproT4V1kC0KQVL+JDqk9
         90X8L1po4mO4rHLXMfipRgIOphubp+BLhqMMLRi7QYP9YZQlKHvfFi4mciKhhYiJ+b4P
         v2EzbWKiSkt5asEnG6wFTqHQdzsM8oa6I6bB74LcivDIgxlu8oucVkpOD9K4CYzzLUuQ
         XYVQU8Pv8diuVc6dS5M/zsjmsPPqG9RC8si1SEVJnzuam6wGUGAfAKDq6a5+j3EvKtuk
         YqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=5Dz4XLfBzjqlbbL0ueGli23xTgGd/JPlHwuKsakcNuk=;
        b=L1AR/rRgQAfbmsjTMiaLsk/pK9YOYGxnJH992CUps/5SnUryh1T2W92noN2Yg4bAHa
         Qsrqz+k/mnvqECkuXRKZtn809XjuxrqcrlxB93/I92MPlIvZek4wgvP2VScQxEXmZqNg
         1p8Rf5zsHQpgrdtfI8+55xGvI3ByfMlm13/e7cFg4mTkHK3/yPdetFxIjX25Pn6ZXDEX
         R3zDw+FO+g6zoWvdV/DpQ032iglpn84XY0hKJx6hYh1MJ27YgSUE8amTvDWPwK/OpF3e
         cSQ1kh+cr8kzWyKa+Zvn8wvXG6S0O+5UHczyal6I/QkWEKe8eA5zm9XSF/7/UFrQAfAB
         HPsQ==
X-Gm-Message-State: ALoCoQnOH5tF3aOynX3+Uz4MJ03Ap8ModYJrVln429JlIGdO3kKuSnxsVRoVG0y4TUBXG/Nc69Il
X-Received: by 10.42.159.129 with SMTP id l1mr2367447icx.15.1423679075756;
 Wed, 11 Feb 2015 10:24:35 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Wed, 11 Feb 2015 10:24:35 -0800 (PST)
In-Reply-To: <xmqqk2zouxnx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263686>

On Wed, Feb 11, 2015 at 10:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> On the other hand, there's this [1] and this [2] from the FSF, which
>> recommend a copyright blurb at the beginning of every source file.
>> Though actually the recommendation is to include a GPL blurb too, not
>> just a naked copyright line like I used. But I get the feeling that the
>> FSF's recommendation is more for ideological than for legal reasons.
>
> It is relatively recent (late 1980s) that US became part of Berne
> Convention (1886).  Before that you had to write Copyright and All
> Rights Reserved (or Todos Derechos Reserrvados) in Buenos Aires
> days.

Quoting from wikipedia[1]

(note however that when the United States joined the Convention
in 1988, it continued to make statutory damages and attorney's fees
only available for registered works).

Does that mean if somebody would infringe the GPL on git (e.g. selling
a modified git version without giving sources), it would be harder to
tell him to stop because of the missing attorney's fees in case we drop
out the copyright notices? (I have no deep understanding of legal
processes in the US).

>
> It is not surprising to see the more cautious practice from the
> older days in recommendations by an old organization like FSF.
>
>>>> Is there a reason you did not append the tests in 7509 ?

You convinced me that having to start with an orphan commit justifies
a new test file as well as the nature of the test.

>>>
>>> Hmph.
>>
>> I don't know what "Hmph" means in this context.
>
> "Hmph, it might deserve more thought, but I do not have opinion
> right now".

[1] http://en.wikipedia.org/wiki/Berne_Convention
