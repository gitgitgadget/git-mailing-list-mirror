From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH] builtin/clean.c: Handle disappearing files
Date: Fri, 15 May 2015 14:13:32 -0400
Organization: Twitter
Message-ID: <1431713612.17436.27.camel@ubuntu>
References: <1431638200-20449-1-git-send-email-dturner@twitter.com>
	 <xmqqk2waj0js.fsf@gitster.dls.corp.google.com>
	 <1431640373.17436.16.camel@ubuntu>
	 <xmqqbnhmiz78.fsf@gitster.dls.corp.google.com>
	 <1431642839.17436.22.camel@ubuntu>
	 <xmqqy4kqh0n8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 15 20:13:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtK7C-0008Vw-TN
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 20:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754710AbbEOSNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 14:13:36 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:36523 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754661AbbEOSNf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 14:13:35 -0400
Received: by qgfh8 with SMTP id h8so4974413qgf.3
        for <git@vger.kernel.org>; Fri, 15 May 2015 11:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=lbJRxyCUm4k+Rir08kizgYBxsb/QgzpbUVzg9j6KNl4=;
        b=hdSRCkWb9RWWn/tYzYaHz+0mLWGnVrKQ33qGybI3sOEykBd4xa8Ez4r6BV3jJHWhKR
         RwFLif4/dG+SoKCtgWBCzdx4e/0n4b2d+VaMmATx2Q9GdMJTLuOgurTkH8VPILQExnW4
         Vnb/bpT4ZU1x2LtmyqcEjHGZTLHKzgLdJ4tiRAnXVu6U4E+mGfcQA4sfth4A0xSGAslf
         VtS5FGN2Rtpx1DsD2Fnxc/K1u31500eoTSLWzbQuhjbEod2hEwRmRMygCIssFcuoaMqz
         NirTTDwslUe67JVIKXqhsCvH6gFKGGuDidPaauqBcv0B3mfPupwD8Ex4XRkyF4pI0Ppl
         dU8A==
X-Gm-Message-State: ALoCoQkhqI4+inRkskFKxAZpKcXTBpmmZ6lEmfI1Fx/GoiyZCL+IUjt3gpdzS53BRcHKGKeYvyFG
X-Received: by 10.140.43.100 with SMTP id d91mr14153074qga.77.1431713615162;
        Fri, 15 May 2015 11:13:35 -0700 (PDT)
Received: from [172.22.38.222] ([192.133.79.145])
        by mx.google.com with ESMTPSA id k19sm1522260qgd.3.2015.05.15.11.13.33
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Fri, 15 May 2015 11:13:34 -0700 (PDT)
In-Reply-To: <xmqqy4kqh0n8.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269163>

On Thu, 2015-05-14 at 22:26 -0700, Junio C Hamano wrote:
<snip>

OK, I'm sold that this patch is not a great idea. But:

> If your "build statistics" thing
> created a temporary before "clean" started to run (causing 'clean'
> to notice that as a cruft), and if "clean" gets to remove it before
> the "build statistics" thing finishes what it was doing accumulating
> whatever data in that file, when "build statistics" thing finally
> tries to use the file, it no longer is there.

Only if the build statistics file is included in the pathspec for
clean.  

So maybe we should just move the lstat below the pathspec check.  This
is probably faster in some cases anyway.  What do you think?
