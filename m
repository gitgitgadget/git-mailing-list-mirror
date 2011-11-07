From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] blame.c: Properly initialize strbuf after calling textconv_object(),
 again
Date: Mon, 07 Nov 2011 18:31:23 +0100
Message-ID: <4EB815EB.30702@gmail.com>
References: <4EB7FEE6.9000609@gmail.com> <7vy5vr282s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 18:33:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNT4m-00051z-FL
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 18:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502Ab1KGRdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 12:33:36 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40921 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755812Ab1KGRdf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 12:33:35 -0500
Received: by bke11 with SMTP id 11so3816611bke.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 09:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=IMUVCndxE+Ge4/xOo7cux69t24Pm9YQDvoDDO2Lejaw=;
        b=eKQLBoUwqHyqZPzmG2WTXuxh1VU2NmJM1xuip9XJVdIW8ANTmChfYak9mnfJH1A2/2
         QHVWb4+hmEcjCgrMXo3WYtZu2KTHpYVRhJRGFeZjyZpnsIMqW4KFgX9ndtFi++SkVIV0
         6OlgZXTEMaHwclhkqZ5fS6DXTIGvjKyA3Yrag=
Received: by 10.204.130.85 with SMTP id r21mr20306186bks.38.1320687214096;
        Mon, 07 Nov 2011 09:33:34 -0800 (PST)
Received: from [130.73.68.203] (jambul.zib.de. [130.73.68.203])
        by mx.google.com with ESMTPS id e14sm18279194bka.0.2011.11.07.09.33.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 Nov 2011 09:33:33 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7vy5vr282s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185004>

On 07.11.2011 17:47, Junio C Hamano wrote:

>> 2564aa4 started to initialize buf.alloc, but that should actually be one
>> more byte than the string length due to the trailing \0.
>
> Even when the conversion result is a zero-length string?

In this case, yes. The string buffer is initialized (and detached) in 
run_textconv, which calls strbuf_read, which grows the (yet empty) 
string to 8192 bytes. So alloc is always > 0, and the detach will trim 
alloc to len + 1.

However, Peff made another valid point and I'll send v2 soon.

-- 
Sebastian Schuberth
