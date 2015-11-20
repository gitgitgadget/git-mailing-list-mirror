From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2] run-command: detect finished children by closed pipe
 rather than waitpid
Date: Fri, 20 Nov 2015 14:05:44 -0800
Message-ID: <20151120220544.GC18255@google.com>
References: <1448053719-28340-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: peff@peff.net, git@vger.kernel.org, johannes.schindelin@gmail.com,
	j6t@kdbg.org, tboegi@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 23:05:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZztoW-0002Zn-JK
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 23:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162541AbbKTWFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2015 17:05:48 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35408 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759535AbbKTWFr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2015 17:05:47 -0500
Received: by pacej9 with SMTP id ej9so128293803pac.2
        for <git@vger.kernel.org>; Fri, 20 Nov 2015 14:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=OKxN/I7/V8xqIRB4qMUVOOnxU/zffPWPJ++CTnCy7dQ=;
        b=FS8pRELcqer6QrmiZZ1Oml9T78HL42bI5nU44HZ5n6WJnkLcmQPtJuB1KB+O90/Fbs
         EowHixmk3MjPp4g7z6QFU1MZ8iBFLGDKdweNepVFPtv0RIa+FiQ28uU9qmjFF/ySGDQW
         sHwmk66X2Cn45T5AMt8vs92sfiXLPJ/6KUJWNW/SS7tzymKlgIze2Yj8VaZS7wst+EIo
         aPUxCo0zcxOatNstbXJyXuAcAQcj47SHTIIUIqwoQwGrgz/Evu9g8vkhPBjmYfbjk6a+
         /eUtP7ecFMnKz9D4/Y75E0K0RY0mkX0ws5cmB5YNXY/ILgMVjiFcOdJyFKd79q1vz9nv
         vsJQ==
X-Received: by 10.68.195.198 with SMTP id ig6mr21942753pbc.13.1448057147292;
        Fri, 20 Nov 2015 14:05:47 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:1181:fa02:cfb:ba79])
        by smtp.gmail.com with ESMTPSA id hg2sm994994pbb.7.2015.11.20.14.05.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 20 Nov 2015 14:05:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1448053719-28340-1-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281538>

Stefan Beller wrote:

> Detect if a child stopped working by checking if their stderr pipe
> was closed instead of checking their state with waitpid.
> As waitpid is not fully working in Windows, this is an approach which
> allows for better cross platform operation. (It's less code, too)

Can you say more about what is broken about waitpid on Windows?

I ask because it's possible for a child to close stderr without
intending to be finished.  That might be okay here (though the commit
subject doesn't explain so, it is only affecting the workqueue
interface that runs commands in parallel and not the normal
run-command interface) but would need some documentation and could be
counterintuitive.

So if there's a simple way to get waitpid to work, that seems
preferrable.

Thanks,
Jonathan
