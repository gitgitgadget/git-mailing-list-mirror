From: David Turner <dturner@twopensource.com>
Subject: Re: 745224e0 gcc-4.9 emmintrin.h build error
Date: Thu, 10 Jul 2014 15:58:24 -0700
Organization: Twitter
Message-ID: <1405033104.3775.10.camel@stross>
References: <CAOvwQ4hNVvzeCUczi7Qurcycp8HA8KU=u1ntu3fzBwu4fTEzPQ@mail.gmail.com>
	 <1405024438.3775.3.camel@stross>
	 <CAOvwQ4hq5AZ0ZhB-1etUZfLfJ4X=11_03syH2pgY_fi=FSLAPQ@mail.gmail.com>
	 <1405025616.3775.6.camel@stross>
	 <CAOvwQ4h=uFCN36dQt4uqwJv8393iVhiCh09+71DhhzyWrbCfUA@mail.gmail.com>
	 <CAOvwQ4in4aufZX2PGkAoX4vWhg_mq+n6Baov_ifGjiyfR_UbPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tuncer Ayaz <tuncer.ayaz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 00:58:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5NIO-0006XP-No
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 00:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbaGJW63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 18:58:29 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:34366 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682AbaGJW62 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 18:58:28 -0400
Received: by mail-qg0-f50.google.com with SMTP id j5so249356qga.37
        for <git@vger.kernel.org>; Thu, 10 Jul 2014 15:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=qZ/MTa411XAKMFy6kSEBX71GHK6xNzlnGJWAlzg3h5Q=;
        b=gtx5vtdH3aWNJEnx0pdwwHL0yscEdCMCludRDXx6NR4ODHCYh2dWBRa3Sc7Bec3UYK
         DwfONpu03SsVGQyzP8RPv4V0uPyuoGz8yKdXks1jrkyUB0vzYdPCfR156VJWiu/qyipk
         gqHjaVwM4Vj49ProzePVFRlN0sDyg/a+NustrgjANtXWjAwsqAifdxZnvK3a3eSEkNgS
         mS/o0dr5h9tjHM2Fl4sBpzBig3mvY/CbIf4WmEIFvZiM10+adlUm66gHaU2WWu21C/3P
         7SXvihV8nOzubHnQot+zEb4K0HP3yp6cILPMCn3UzSbAkJf3lQ+p/f1LUE2cbvAdLl1I
         tzKA==
X-Gm-Message-State: ALoCoQlVdF3R3QyYKEY+Q7bD/cMD143IX5gkpJdaz73395nP4MT9MVCSe6rIKfMpYt2I9FLQS8Yc
X-Received: by 10.224.128.9 with SMTP id i9mr4003159qas.50.1405033107624;
        Thu, 10 Jul 2014 15:58:27 -0700 (PDT)
Received: from [172.25.140.220] ([8.25.197.27])
        by mx.google.com with ESMTPSA id z14sm999027qaw.7.2014.07.10.15.58.26
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 10 Jul 2014 15:58:26 -0700 (PDT)
In-Reply-To: <CAOvwQ4in4aufZX2PGkAoX4vWhg_mq+n6Baov_ifGjiyfR_UbPQ@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253227>

On Fri, 2014-07-11 at 00:12 +0200, Tuncer Ayaz wrote:
> Sorry, didn't test properly when I tried with/without config.mak, and
> PROFILE=BUILD was the problem. I had that in config.mak based on
> information gathered from INSTALL and Makefile. To be clear, is
> PROFILE=BUILD (still) supported?

For what it's worth, the problem seems to depend on the combination of
-DNO_NOTRETURN=1 and -fprofile-use.  So I can trigger the same breakage
with this:
---
#define NO_NORETURN 1
#include "git-compat-util.h"

int main() {}
---
gcc -I. -c -fprofile-use=/tmp foo.c -o foo.o

Do we still need NO_NORETURN?  Git seems to build without it under GCC
4.6.3 (Ubuntu's version).  
