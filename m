From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3 09/16] index-helper: use watchman to avoid refreshing
 index with lstat()
Date: Thu, 07 Apr 2016 20:14:43 -0400
Organization: Twitter
Message-ID: <1460074483.5540.9.camel@twopensource.com>
References: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
	 <1459980722-4836-10-git-send-email-dturner@twopensource.com>
	 <xmqqh9fdxcht.fsf@gitster.mtv.corp.google.com>
	 <xmqqd1q1xc8r.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, pclouds@gmail.com, aevarb@gmail.com,
	jeffhost@microsoft.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 02:14:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoK4e-0007Bi-Hh
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 02:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756548AbcDHAOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 20:14:52 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:35842 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756419AbcDHAOv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 20:14:51 -0400
Received: by mail-qk0-f175.google.com with SMTP id i4so38132150qkc.3
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 17:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=NvhE3t1Lti0MSTB74F2iiNMYbIcAEjWun/QDGua/jqY=;
        b=05faoDt/vq4tBmoRk9Uo+UHhclOEx0g2Ja11a8DHvCmieDHnxngK4rtWC1hsZo8x4e
         XYqdDWkGIgv3g3xA3VVEKEuxnPuKYzfpS6SOA0W8MuBNSfLbQrNz09xAHvrghQivsgIg
         zv7qfgRb9vRw3tZO4V9FvLzADbTuNg8NYzjooSt+22vVoqbzZptkMIH03/ul9gs1gNzA
         a+t8LorwPPH0v+0FUr8hb9ZN2hZ9Q6dGPIKXv76ksALchqKPj7+/LBrIktQPSCyNtPzO
         8aJPXca1/vdfXRqxMwAMY28Ay3ftM61FZCGnammH9OfP03922GpT6ctF660EAnJ7qa5x
         oD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=NvhE3t1Lti0MSTB74F2iiNMYbIcAEjWun/QDGua/jqY=;
        b=f7odE28u4w2hbZnIiafwxzpEeM5KVuCSnzZw9Zl2CXaTa6GMgM8HciYzo/El4nfKj3
         ez27gzxkku8rxOmWOc4kh7Kqh8ue4JJgRdMrX4/l/rCz6TsMhVjICsjgxL1WYC4KbeN2
         6n+QiLFg3KEREsE8vN0OhKhIF7gZdhBUUYtq6keNh8m9IuMLX3vaTmbR6QnYS9Ryw+Vk
         zY5w0rfc0u3GnFZ1/82FNmZvObMYTxdxX2SP8H1H5FInwE+M1Rh+Y2aQ37JmIKdUH/8B
         UKZSA/qSysjE/m3jjONv5hAwe9oljsf/zpBPRz5QrzlypCavpX7SLH2WuRWoJp4f9uGs
         k+pA==
X-Gm-Message-State: AD7BkJLfKvtTi4DP7SZI8r3oYU9ErRb2LrDLfBlPtbzHh5gBRMe2PAswH13OrHpBvC5Z/w==
X-Received: by 10.55.75.203 with SMTP id y194mr7859278qka.2.1460074485120;
        Thu, 07 Apr 2016 17:14:45 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id o77sm4461273qgd.37.2016.04.07.17.14.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Apr 2016 17:14:44 -0700 (PDT)
In-Reply-To: <xmqqd1q1xc8r.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290995>

On Thu, 2016-04-07 at 15:52 -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > > +		untracked = data + len + 8 + bitmap_size;
> > 
> > This breaks compilation as data here is of type (void *).
> > 
> > There may be similar breakages in this patch.
> 
> It turns out that this is the only one, and
> 
> 	untracked = (char *)data + len + 8 + bitmap_size;
> 
> is a sufficient fix (I've squashed it in to my copy).
> 
> Thanks.

Thanks.  I've squashed it into mine as well but with const char *
instead (seems maybe cleaner to me)
