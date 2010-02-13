From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 5/5] Use kwset in grep
Date: Sat, 13 Feb 2010 18:38:12 +0100
Message-ID: <4B76E384.2070602@gnu.org>
References: <20100213141558.22851.13660.stgit@fredrik-laptop> <20100213142110.GF9543@fredrik-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 13 18:38:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgLwl-0007EO-Dl
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 18:38:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757658Ab0BMRiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 12:38:18 -0500
Received: from mail-fx0-f227.google.com ([209.85.220.227]:36691 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757524Ab0BMRiR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 12:38:17 -0500
Received: by fxm27 with SMTP id 27so125843fxm.25
        for <git@vger.kernel.org>; Sat, 13 Feb 2010 09:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=7j3n7xkY9x3u8NZs2EEkVVI57d6GwYXp8eJKYPs7wLo=;
        b=C6YX6AvXct7t0VyZaWPc8xm+tJwGh5sn/CC9n8IH5C6ITp3IT41tdOKO6xHH0ARjuv
         9rtefJgHU9GjGjynmBWc+jIn5D/UXjjW0PwvuQpylQLU79ETrtrQkl4Pqmt4L37L51ps
         MT7/V4UyE3a53udrhEPXkzlZv+t54WYPg/5v0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=S03vpYL4UOoIPyzBbB/pyjaO3VJ2n5IMfGvbaMEl5QdK8+PF8mptwp/m9hc0rqktAs
         nVgkorpDZ7mOFjUfjf5uXwkaGt75G6n9cGOLMo8vHuFcBGbS80/9anKxAILZ7qOtxRZZ
         oaiphdoJt2WTZLW8uVsCJTVfQiMOUxFYpexj8=
Received: by 10.223.5.82 with SMTP id 18mr3332178fau.79.1266082695429;
        Sat, 13 Feb 2010 09:38:15 -0800 (PST)
Received: from yakj.usersys.redhat.com ([85.93.118.17])
        by mx.google.com with ESMTPS id 18sm7459120fks.4.2010.02.13.09.38.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Feb 2010 09:38:14 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.1
In-Reply-To: <20100213142110.GF9543@fredrik-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139819>

On 02/13/2010 03:21 PM, Fredrik Kuivinen wrote:
> Best of five runs in the linux repository:
>
> before:
>
> $ time git grep qwerty
> drivers/char/keyboard.c:        "qwertyuiop[]\r\000as"                          /* 0x10 - 0x1f */
>
> real	0m1.065s
> user	0m1.400s
> sys	0m0.536s
>
>
> after:
>
> $ time git grep qwerty
> drivers/char/keyboard.c:        "qwertyuiop[]\r\000as"                          /* 0x10 - 0x1f */
>
> real	0m0.621s
> user	0m0.560s
> sys	0m0.564s
>
> So we gain about 40% by using the kwset code.

Hmm, on a more accurate review for

     git grep -e foo -e bar

you're creating two kwsets, so a Boyer-Moore search be much 
simpler---the performance would be the same since that's what kwset 
degrades to for a single string, but you'd probably save around 600 
lines of code...

Paolo
