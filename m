From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH/RFC 6/7] refs: add update_refs for multiple simultaneous
 updates
Date: Thu, 29 Aug 2013 14:38:50 -0400
Message-ID: <521F953A.9090309@kitware.com>
References: <cover.1377784597.git.brad.king@kitware.com> <518ba77096664a679e4c7212e4cc4d496c6b38d3.1377784597.git.brad.king@kitware.com> <xmqqhae85rbl.fsf@gitster.dls.corp.google.com> <521F90EC.6040208@kitware.com> <xmqqmwo04ac2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 20:40:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF793-0002Df-1g
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756032Ab3H2Skc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:40:32 -0400
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:38459 "HELO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753417Ab3H2Skb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Aug 2013 14:40:31 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]) (using TLSv1) by na3sys009aob108.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUh+Vn9SYuOUSohk7ucwQBUBeebseW9O9@postini.com; Thu, 29 Aug 2013 11:40:31 PDT
Received: by mail-ob0-f178.google.com with SMTP id ef5so887158obb.23
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 11:40:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=kH1NT4kAilKMk6r2/rTijH6CJcmt6duhA6c9XkkcF04=;
        b=Q/g4l0804c79SkZqRQk0qBV2C3E55W6BS6VmSVQXioddSCRCB4iJ//1qFbVDwtTAVO
         ldEujttiKzFqr0FNyJEwcXUuU338Q5TLbHeiaifXWPWitj4WwU4oi5dXA+QJ4aQTQ3yo
         qxj+6UaXHDIftJ1fIKjXALyWhqyPJ20F27dWd2F5M8udTX2XaILKcupTCTTRoHtDrKl5
         OucRVJ0WsWmOcRK3NGKjspbZslmGjyk4Fys8l0+Joq4qFlX6thza8nlgvpVhCix8PNMT
         JtP1KQ8XmaCGreRoZKIdcgrAQ9hxndsP1c6CM2Qy7XxWLOktJCfvhtlIiD8hOnlU/Ycz
         np5g==
X-Gm-Message-State: ALoCoQk13nHkEQWgcxLRFM7Vg/ZmHfFHUr8zr6koOp6FypsCGXzLCKvKTqU9/3HQBMPB0IYuYhv11cWZFSTELLjroTcMYLYwyK6o+7WEboUrUqv0cK3I2xLNuKedKQQcGfgT8ZQwqBVuR8pubxLbOsZZiMEzPMzUAw==
X-Received: by 10.182.29.198 with SMTP id m6mr3539011obh.105.1377801630711;
        Thu, 29 Aug 2013 11:40:30 -0700 (PDT)
X-Received: by 10.182.29.198 with SMTP id m6mr3539006obh.105.1377801630645;
        Thu, 29 Aug 2013 11:40:30 -0700 (PDT)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id z5sm32821194obg.13.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 11:40:28 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
In-Reply-To: <xmqqmwo04ac2.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233331>

On 08/29/2013 02:32 PM, Junio C Hamano wrote:
> But it may not be a bad idea to keep the callers dumb and have this
> function always sort, dedup, *and* fail inconsistent request.

I agree.  I was just starting to write the comment for update_refs
and it basically would have said "always use ref_update_sort and
check for duplicates first".  We might was well build it into the
function.  If some call site in the future wants to optimize a case
known to be sorted it can be refactored later.

Thanks,
-Brad
