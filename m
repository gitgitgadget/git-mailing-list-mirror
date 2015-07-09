From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] clone: simplify string handling in guess_dir_name()
Date: Thu, 09 Jul 2015 14:21:18 -0700
Message-ID: <xmqqfv4xuiwh.fsf@gitster.dls.corp.google.com>
References: <CAHGBnuNLoNsxPK4YQ+HnT_q8F-HrVC_y9pZwB4G88jCq0-wCPg@mail.gmail.com>
	<0000014e740f7a8a-2c988a36-633e-4b30-8024-cb4a1de1a8a2-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 23:22:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDJHE-00065S-Pk
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 23:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754016AbbGIVVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 17:21:38 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:33059 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754007AbbGIVVX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 17:21:23 -0400
Received: by iggp10 with SMTP id p10so22992028igg.0
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 14:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=2s35sZfCCrjbJPHgPUk9Xl0RAVDklSYg3eZ4mKbqXZQ=;
        b=J8VcpU0xovAjd0wdd0SRXf/sG4pg+ET4+dVPsp/X6zHTIraWMW+NTVgpOaLMM3tTMF
         ovXnNq5yiSV0Vh/ebAq/y100xSoKRBXFo1mHqmWA8/9C2eagO3G1ITIyToBfEjspLeJZ
         A+uXlbkT8oVuDEOKBcbFGzIRZM42G+nIx1KUHJeXm3OY08JXPC6ByVaLXxgMNjaSY72z
         b/QtRSPGQgvpdvy8mwOvMBWT7K6mQRLOeuSnKjoTWN/8gryQqOpYEdZCTdmQBb2llEbC
         BNF2hUW4Ufn5ztLkVijvihO+FlNrV4tNCrKQn1Q5x1gZsscembdpZddlpAcnc56bsxVU
         Q8RA==
X-Received: by 10.107.162.147 with SMTP id l141mr29559330ioe.77.1436476882625;
        Thu, 09 Jul 2015 14:21:22 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:647a:d824:a8a3:7bb0])
        by smtp.gmail.com with ESMTPSA id vk8sm17388943igb.4.2015.07.09.14.21.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 09 Jul 2015 14:21:20 -0700 (PDT)
In-Reply-To: <0000014e740f7a8a-2c988a36-633e-4b30-8024-cb4a1de1a8a2-000000@eu-west-1.amazonses.com>
	(Sebastian Schuberth's message of "Thu, 9 Jul 2015 18:24:08 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273778>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> -	if (is_bare) {
> -		struct strbuf result = STRBUF_INIT;
> -		strbuf_addf(&result, "%.*s.git", (int)(end - start), start);
> -		dir = strbuf_detach(&result, NULL);
> -	} else
> +	if (is_bare)
> +		dir = xstrfmt("%.*s.git", (int)len, start);
> +	else
>  		dir = xstrndup(start, end - start);

The last one needs to be adjusted with s/end - start/len/.  The
last-minute rewrite without testing shows; your first two patches
correctly used "len" ;-)

No need to resend.  Will locally tweak before queuing.

Thanks.
