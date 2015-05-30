From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] commit: fix ending newline for template files
Date: Sat, 30 May 2015 09:59:38 -0700
Message-ID: <xmqqfv6eatmt.fsf@gitster.dls.corp.google.com>
References: <1432620908-16071-1-git-send-email-patryk.obara@gmail.com>
	<1432620908-16071-3-git-send-email-patryk.obara@gmail.com>
	<CAPig+cTt5sQ=49qS2+8ZOtiX61kHjAisAvpP7K3XPhtNtCatOg@mail.gmail.com>
	<xmqqpp5kh8a0.fsf@gitster.dls.corp.google.com>
	<CAPig+cR=Mrgb+-ZZcM6m7AcL25gXYtmEVpO3c23k_UKXPgyQnA@mail.gmail.com>
	<xmqqwpzrb0kb.fsf@gitster.dls.corp.google.com>
	<CAPig+cTrW9f1TGvpr4KH+EcOsy=FWvGRj6ZQM6nsFyXc15c4qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Patryk Obara <patryk.obara@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat May 30 18:59:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yyk6z-0004oE-EP
	for gcvg-git-2@plane.gmane.org; Sat, 30 May 2015 18:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757203AbbE3Q7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2015 12:59:43 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:34477 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757071AbbE3Q7l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2015 12:59:41 -0400
Received: by ieczm2 with SMTP id zm2so83419622iec.1
        for <git@vger.kernel.org>; Sat, 30 May 2015 09:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=82VD9sLmshaimHmHYGYa/LoF3xQhe6HpUojNi5uQniE=;
        b=FpTeWvRFIxjd1MZrT7MPi/sAKderc3YblkJa06fOWBG21YEf5BRpLTKiDMmZX3bO2J
         oP1FXVWyg0xApONgy8x32BlYk0kNMgcliG6cbufprnz44xoJFmrx2PkjYHIk0bv4TyvU
         b9pbcFyZTZlEiS3OMEbCVgQX3o0lD9csZJLCU4h/Rj1lf+iasqhiV7T2atLKsZdvf39X
         v37LvDgrD6fVuASC4WSx0jbHsd3bvsKo5dUqvqoVKKlc7MeGsgD7A/HyaHVsasVniIuG
         BmapeebKilLXmufOYi/cDfx4Gn2B8ejz1m6HmnG5JwchghMSWGTcP1LXKe0xDsZs7ApH
         hBLQ==
X-Received: by 10.42.203.4 with SMTP id fg4mr20561487icb.52.1433005180635;
        Sat, 30 May 2015 09:59:40 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d9c8:419b:acd5:cf1d])
        by mx.google.com with ESMTPSA id q78sm6672260ioe.9.2015.05.30.09.59.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 30 May 2015 09:59:39 -0700 (PDT)
In-Reply-To: <CAPig+cTrW9f1TGvpr4KH+EcOsy=FWvGRj6ZQM6nsFyXc15c4qg@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 29 May 2015 18:25:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270290>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, May 29, 2015 at 4:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> By default, we should run clean-up after the editor we spawned gives
>> us the edited result.  Not adding one more LF after the template
>> when it already ends with LF would not hurt, but an extra blank
>> after the template material does not hurt, either, so I am honestly
>> indifferent.
>
> I had a similar reaction. The one salient bit I picked up was that
> Patryk finds it aesthetically offensive[1] when the template ends with
> a comment line, and that comment line does not flow directly into the
> comment lines provided by --status. That is:
>
>     Template line 1
>     # Template line 2
>
>     # Please enter the commit message...
>     # with '#' will be ignored...
>
> [1]: Quoting from the commit message of patch 1/2: "...which is very
> annoying when template ends with line starting with '#'"

As I said in the message you are responding to, I do not think it
would hurt if we stopped adding an LF after a template that already
ends with LF.  I think I am OK with a patch that does so without
doing anything else, like changing when clean-up happens, etc.
