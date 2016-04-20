From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 3/3] http.c: implements the GIT_TRACE_CURL environment variable
Date: Wed, 20 Apr 2016 13:07:54 -0700
Message-ID: <CAPc5daWhDToqoeeGrhzjVuDgNu1ar0RvF10iKpH-61yj=z6fVQ@mail.gmail.com>
References: <20160420162825.62380-1-gitter.spiros@gmail.com>
 <20160420162825.62380-4-gitter.spiros@gmail.com> <xmqqzisoun5n.fsf@gitster.mtv.corp.google.com>
 <5717DEEC.4000903@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Elia Pinto <gitter.spiros@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 22:08:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asyQ6-00011q-IM
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 22:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbcDTUIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 16:08:15 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33360 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902AbcDTUIO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 16:08:14 -0400
Received: by mail-yw0-f193.google.com with SMTP id o63so8723682ywe.0
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 13:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=RrakebgwPV7N1qkvBLc2qqU+pcM4+kRXw4MvVUxOhU0=;
        b=XHB1/br0OO8UQuJwDwYDAhCqTIMiTUkWfJyJFKgYlt4pP/0K0YwPS8Ygk9TaNiil2Z
         qlYHIKWa9SPKZxonzlxXLhzx4j6j9WQUFqGAdChVvmGOFDJ27lDNt6l9shPwyy9MhuYN
         Mc3bwM/nYerwbMp8V4GkubW5XGeaYmU5miXPRXiqgqsn0vr8+Bf7HJN8wIjVhRntZgEe
         lzd862XeTndxOCag5q5pgL8kZKwr6CWnSWZb9CQZg00UfWeeSRq+djDqsBLazn/OCSuf
         OxnTfBykUkEiXH4O7FC3cptvLh3/JmvFWaBgcOrX7HD9b9zrX5/ahQle9dZQPDimvOXb
         S1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=RrakebgwPV7N1qkvBLc2qqU+pcM4+kRXw4MvVUxOhU0=;
        b=dNuq2ujthKGYZxIg0QWWBtQ57ji0Cp0IpNWXYj+FbwfoLM5SlsmJ26yflrVhazzlD3
         2Ljc+7lzY5H5GgrI5tmosK3L141Aa+7mNaT9rrp0UCcfs46xcp69r4lFHCoIz7TEvwXb
         OEyg6YZh2ZwDGEq+EsFhejTNXGQ7KXPtwQSctXMHbL/Cb5MYmfHoqBvQSQB3Bj4b8gW8
         Y9MQmczL+3EFqfRLX3lk7VY3wxGWVJRoC2OoJ41ZHCSVGn70HM4cTooOwuq6y5VxHoMn
         0xXdolMXoqIiwL/CFbxcTvgf0s+K61POQ5ZF00VKF2zSTCVB9iZnu6LyBwQfndZwZ5Xu
         YrYA==
X-Gm-Message-State: AOPr4FWWiv8IdNP8knGCJl5zIghkyJ//hd+p9kti3MCitJRcqqgi3zIsqElAFhqGXH1NiTZl4zPIgbHMO8LOIQ==
X-Received: by 10.129.80.11 with SMTP id e11mr5156160ywb.197.1461182893494;
 Wed, 20 Apr 2016 13:08:13 -0700 (PDT)
Received: by 10.13.251.71 with HTTP; Wed, 20 Apr 2016 13:07:54 -0700 (PDT)
In-Reply-To: <5717DEEC.4000903@ramsayjones.plus.com>
X-Google-Sender-Auth: mKQphFcfp3s3OXNFVds7ZXaxTUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292070>

On Wed, Apr 20, 2016 at 12:56 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>>> +void curl_dump(const char *text, unsigned char *ptr, size_t size, char nohex)
>>> +{
>>> +    size_t i;
>>> +    size_t w;
>
> As I said in a previous email, curl_dump() should be marked
> static here (and remove the declaration from http.h). Unless,
> of course, there are plans for future use/calls being added?

Good point. Thanks.
