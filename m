From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] buitin_config: return postitive status in get_value
Date: Sat, 28 Jul 2012 20:29:23 +0700
Message-ID: <20120728132923.GA31388@do>
References: <1343475730-18743-1-git-send-email-nikolay@vladimiroff.com>
 <CACsJy8BUU13H1tRfTtUme_7u0Jf0upca31U-VNhXva_0R2MLoQ@mail.gmail.com>
 <CAJg5NvdAq_zEx2phVGS4EiUfqMtFJA2Bo=y1d3FJyWXtzMwCTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nikolay Vladimirov <nikolay@vladimiroff.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 15:30:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv76A-0000LI-70
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 15:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603Ab2G1NaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 09:30:20 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62720 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566Ab2G1NaU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 09:30:20 -0400
Received: by pbbrp8 with SMTP id rp8so6758785pbb.19
        for <git@vger.kernel.org>; Sat, 28 Jul 2012 06:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=rMMXX9cYGo93Uimhvh9u4R2qq8pgfPQ2Q1kNsNffa+Y=;
        b=LYWwi9Nn8qX5QUvnFjoiqulLENHj48czEAqhN1lwSbVl6BfUkZ4Hh8TseDl4Thq69b
         6d544d8GbVM2gixAUnvBdCjaNlzGIFTNiUaEHML0JL0bAGaOK2i3UbuGwgca57ihAmVB
         YBtjy0XNteTnkRDLVhOeQlsPZIufJQr4oZj2njPcqqkOXvHErEu1vUl1Cm38zz8CnR/5
         DO2FXN1qh8+q4+cmxXE1fD5IwYgnBB374+9krK+/9MvfGE6eXMQ+T9gEfii/0eiyJlPY
         UVXbIxtDys0R2rff9qdTv4vIB04+pmvTIRQc90woqzxrAwvkuGjHVlVZ51yhlcGTS1td
         C0qg==
Received: by 10.66.75.133 with SMTP id c5mr12482662paw.24.1343482219672;
        Sat, 28 Jul 2012 06:30:19 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.32.150])
        by mx.google.com with ESMTPS id ob9sm3985869pbb.28.2012.07.28.06.30.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 Jul 2012 06:30:19 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 28 Jul 2012 20:29:23 +0700
Content-Disposition: inline
In-Reply-To: <CAJg5NvdAq_zEx2phVGS4EiUfqMtFJA2Bo=y1d3FJyWXtzMwCTw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202435>

On Sat, Jul 28, 2012 at 04:18:49PM +0300, Nikolay Vladimirov wrote:
> But the behavior now seems kind of strange, or maybe I'm missing something:
> # git config foobar; echo $?
> error: key does not contain a section: foobar
> 255
> 
> # git config foobar.info; echo $?
> 1
> 
> git version 1.7.11.2
> 
> I would generally expect the both to behave the same way.

Then the following patch may be better because it leaves other cases
untouched (I'm not saying that we should or should not do it though)

-- 8< --
diff --git a/builtin/config.c b/builtin/config.c
index 8cd08da..d048ebf 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -199,8 +199,10 @@ static int get_value(const char *key_, const char *regex_)
 			goto free_strings;
 		}
 	} else {
-		if (git_config_parse_key(key_, &key, NULL))
+		if (git_config_parse_key(key_, &key, NULL)) {
+			ret = 1;
 			goto free_strings;
+		}
 	}
 
 	if (regex_) {
-- 8< --

-- 
Duy
