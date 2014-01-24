From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH/RFC 3/3] merge-recursive: Tolerate missing file when HEAD
 is up to date
Date: Fri, 24 Jan 2014 14:45:58 -0500
Message-ID: <52E2C2F6.2030909@kitware.com>
References: <CABPp-BGAsrrjcZxVirzKU_VEyUM1U=4TFj18CieKKE7==c7v2A@mail.gmail.com> <cover.1390574980.git.brad.king@kitware.com> <5e5bfe752655c39fca626811972af9d0a90ddab9.1390574981.git.brad.king@kitware.com> <CABPp-BEK9+_ebRiodCp59DHJZExYn3N1jjtBsikSmwt-s_v_0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 24 20:54:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6mpQ-00082q-Qn
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 20:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbaAXTyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 14:54:08 -0500
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:56012 "HELO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751582AbaAXTyG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jan 2014 14:54:06 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]) (using TLSv1) by na3sys009aob105.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUuLExKCNJS2hnMjOwS9nMNAHzzU3xNwN@postini.com; Fri, 24 Jan 2014 11:54:06 PST
Received: by mail-ie0-f178.google.com with SMTP id x13so3378350ief.9
        for <git@vger.kernel.org>; Fri, 24 Jan 2014 11:53:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=iYL7j3KK9fz59r4RUlcC8Gpcbrd08iPDSWSkUoNB5Bw=;
        b=kKeRdfR5d92pKqYb/af/di82VLBNfA6uONGL/hI7nWUGBy5iDKVYuI3gA8j7ewOjen
         eTgra8Tlp2k81xRwwqSFkotLImegUbOGofA1R/U5FIyqwmjcAOJFwBjE4jMLE84+ltst
         cM4P+Fiu5F6xz+bgPB7JHvMkgxfrq0hBTmLXwgYlI9m+kSpDi+WvcFMB/dUdEzMQ23J1
         gwlkXqERBYTFkKv/le6JrnIKMwxEFLvwU/NL1T0J1lg3Xb5HBUYdyEX8+r+v2ziQWoDK
         knssgTL+jiz5Rbqx/CNFnVfOWXDwinBp80f00Veon2qg5p/sv3ohvS+uP9DTzPhdQfpA
         VBjA==
X-Received: by 10.42.250.132 with SMTP id mo4mr12271392icb.34.1390592732367;
        Fri, 24 Jan 2014 11:45:32 -0800 (PST)
X-Gm-Message-State: ALoCoQk0zMAv/MH4VPTwApeHf9COfCkBgayPZ60/p7p4sCRrRNG1lHxbPMGZx1QlknLP6sYwEZXu8ahyBbtGkag29DqmSjQtFEHuSlGPorYl77CEp2Rvqb6Qgf9bM3J/imqE3XK9pNcvR3shqCDBHT6FiA+6/iJCfQ==
X-Received: by 10.42.250.132 with SMTP id mo4mr12271174icb.34.1390592731770;
        Fri, 24 Jan 2014 11:45:31 -0800 (PST)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id x6sm13091758igb.3.2014.01.24.11.45.30
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 24 Jan 2014 11:45:30 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <CABPp-BEK9+_ebRiodCp59DHJZExYn3N1jjtBsikSmwt-s_v_0A@mail.gmail.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241025>

On 01/24/2014 01:42 PM, Elijah Newren wrote:
> While this change does work for the particular new testcase you provided,
> there's a more complex case where merge-recursive is failing

I'm not surprised.  The change felt much like covering a symptom.

> it's just that we want the stat information refreshed if and only
> if the file happens to exist in the working tree.

We can add a refresh_flags argument to make_cache_entry to request
this behavior.  I'll send an updated series soon.

Thanks,
-Brad
