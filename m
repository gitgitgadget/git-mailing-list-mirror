From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v6 03/32] files-backend: break out ref reading
Date: Thu, 25 Feb 2016 15:11:38 -0500
Organization: Twitter
Message-ID: <1456431098.18017.52.camel@twopensource.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
	 <1456354744-8022-4-git-send-email-dturner@twopensource.com>
	 <xmqqr3g1r66h.fsf@gitster.mtv.corp.google.com>
	 <xmqq7fhtr4sq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>,
	git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 25 21:11:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ2GH-0000ph-E5
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 21:11:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933662AbcBYULl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 15:11:41 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174]:33100 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933286AbcBYULk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 15:11:40 -0500
Received: by mail-qk0-f174.google.com with SMTP id s5so24060291qkd.0
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 12:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:organization
         :content-type:mime-version:content-transfer-encoding;
        bh=aPEnYs9qEQTchN43U1hcR6qX5eFh5hA+FhX2m6PGcLc=;
        b=TBfbpXMzmbu2RYXEjB8liKX59+rCvPAXVoepsHiFtuv99GxBj4wGTdYqC5t82HWfN0
         dF6dJx8iOTivYp87ToKvsivZl16MQe5FO5HUAH0BQAokZd5HdvqpQdk89C4lERKuiTlL
         Djh7QCxd4XqskXgM/XhGydW3kRxex/LzIlJrLdQIERT/8IUfaj+9ZmGXZrIbS1gWXqWp
         IzyWM4tSg41DpyiWDMQci5pfipVW7PN3x8ZlNUBtOrnwpI83phsJLsu3pMFrmCthM+5m
         OU55F3ppY4zAfTgYU70+VgZFHFO07DU0v3wpISFrXM7ReFNWnopWyJ20ngfjtsZL+8Vr
         fbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=aPEnYs9qEQTchN43U1hcR6qX5eFh5hA+FhX2m6PGcLc=;
        b=m1TtkHYlvgi51IhPVEpdW/6NWqn2Ab0u7GYXrkB+kiC4c8yIZ6YhJWxxi5xuZRmZRA
         xWyKljIYVkxk8picaIJl6zNQ40QWrqahojkeM9fFd6pwYqAcosP44/eNyFAjvXr6cO9r
         DsbxZ26TU8x6eyIeyE9zbRpbJcn8nf3hCGdgyHT/Wj3imNJHKCVnc2mKgL1VD/46Z25u
         iUBFsCryMjgnhErV3sEPPTU41yja98/uBsCdixuw8A6JeiedWLoe4Jy/0AYoXwvnJWIj
         1vNt9KTyhPEpjPnFXBVejmhJ9i0MMIGsvD32ZBFqDceNolaQyaYHbU33dw6XsClvofg/
         Roeg==
X-Gm-Message-State: AG10YOShblbJfutS0mKG+sT+Wg+UPeLWFhS3RL9DIoIkejwLb4piNymFdCPSBGsDsArB0A==
X-Received: by 10.55.215.131 with SMTP id t3mr58237044qkt.97.1456431099654;
        Thu, 25 Feb 2016 12:11:39 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 141sm3906781qhk.23.2016.02.25.12.11.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 25 Feb 2016 12:11:38 -0800 (PST)
In-Reply-To: <xmqq7fhtr4sq.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287429>

On Wed, 2016-02-24 at 16:51 -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > ...
> > You can of course standardize on signed int, but because this is a
> > collection of flag bits, there is no reason not to choose unsigned.
> > 
> > I _think_ I can fix everything up before pushing out, so please
> > check what will appear on 'pu' before rerolling.
> 
> I managed to whip them into shape enough to pass my compilation test
> ;-)  Other things I had to tweak were small things like whitespace
> issues, initializing statics to 0 or NULL, etc.

Got it, thanks.

Is there some standard workflow here?  I just rebased your version of
my series (bd412fa) on top of the prior commit in pu (9db66d9), fixing
the few conflicts.  (I think there is in general something I'm missing
about how to maintain a patch set under the git.git workflow).  
