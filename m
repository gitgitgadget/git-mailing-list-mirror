From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH v2 6/8] refs: add update_refs for multiple simultaneous
 updates
Date: Mon, 02 Sep 2013 13:20:06 -0400
Message-ID: <5224C8C6.4050500@kitware.com>
References: <cover.1377784597.git.brad.king@kitware.com> <cover.1377885441.git.brad.king@kitware.com> <edaddbd4e303866f789f1a4f755a9da77590aeef.1377885441.git.brad.king@kitware.com> <xmqqob8dul99.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 02 19:22:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGXpA-0000ZL-Mt
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 19:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758661Ab3IBRV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 13:21:57 -0400
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:44904 "HELO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756322Ab3IBRV4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Sep 2013 13:21:56 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]) (using TLSv1) by na3sys009aob106.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUiTJMxpp9CA8RctNZoLmtiEytVW0aCA4@postini.com; Mon, 02 Sep 2013 10:21:56 PDT
Received: by mail-oa0-f45.google.com with SMTP id m6so1608016oag.4
        for <git@vger.kernel.org>; Mon, 02 Sep 2013 10:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=x3eFcqc2S4Hq3k29OG6gEj6CJdZQuTUe+XqoZmWqsfU=;
        b=P5ioRIPjjzf/Q+zhJnr2YYS0F7xJ2LaY62WlGzApmI1JRc5kU8QwJFeEAbhUnSDFxc
         CLBbwWB7PDk/epSESYeXaVoPDXQlP6oy+t67T+jAIotXTyklwE2/sQP1rVT4qxJcxOUJ
         AnUtIwNCUYbRMWye+Zt6180z429YuiERi7WVR809QgjMLHh9MTZa7Uv+AO2mzMGEFIOw
         d6HyT/5QALQKR+JSdDT/GEnC4//pF52YOaBvtbj0/ZFIbdM6ot7QyEvtywZrXBlLN4Cc
         RIu5DQ9c5+/JZJVmE0rhRwQfP7lwjyfIq9Tb7fz7sAP3szoVjtozegL4LU7hOVJwybEm
         Z7Ug==
X-Gm-Message-State: ALoCoQlmZvmtLrOeT3MJVCIdt4rmU/oi8WpHbLBuzziRHop+QdTAS073o0tMhk2Vp4sXoyiGrblFFtOshBU25JO3FRH8+C6BEB5HMDJg195NSzwdwVfmSNyS1swtkQfFQ2Yo0VFj8tv3z3I79WfFmdfuM6P124XCFA==
X-Received: by 10.60.138.136 with SMTP id qq8mr1924334oeb.59.1378142514367;
        Mon, 02 Sep 2013 10:21:54 -0700 (PDT)
X-Received: by 10.60.138.136 with SMTP id qq8mr1924328oeb.59.1378142514285;
        Mon, 02 Sep 2013 10:21:54 -0700 (PDT)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id pt4sm13895786obb.14.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 02 Sep 2013 10:21:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
In-Reply-To: <xmqqob8dul99.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233639>

On 09/01/2013 02:08 AM, Junio C Hamano wrote:
>> Though the refs themeselves cannot be modified together in a single
> 
> "themselves".

Fixed.

> I notice that we are using an array of structures and letting qsort
> swap 50~64 bytes of data

Michael suggested this too, so fixed.

> Optionally we could silently dedup multiple identical updates and
> not fail it in ref-update-reject-duplicates.  But that does not have
> to be done until we find people's script would benefit from such a
> nicety.

We can always be less strict about input later, so I'd like to keep
the implementation simpler for now.

> By the way, unless there is a strong reason not to do so,
> post-increment "i++" (and pre-decrement "--i", if you use it) is the
> norm around here.

Okay, fixed in entire series.

>> +			locks[i] = 0; /* freed by update_ref_write */
> 
> I think what is assigned here is a NULL pointer.

Yes, fixed.

Thanks,
-Brad
