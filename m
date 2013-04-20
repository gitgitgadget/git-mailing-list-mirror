From: Tair Sabirgaliev <tair.sabirgaliev@bee.kz>
Subject: Re: [PATCH] gitk: workaround Tcl/Tk Cmd-TAB behavior on OSX
Date: Sat, 20 Apr 2013 16:45:26 +0600
Message-ID: <A7483D1D-2A01-4C56-85A8-DAD781171333@bee.kz>
References: <5165B758.4070308@bee.kz> <20130420031955.GA30856@iris.ozlabs.ibm.com>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Apr 20 12:45:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTVIi-0005pU-P3
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 12:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754886Ab3DTKpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 06:45:34 -0400
Received: from mail-bk0-f42.google.com ([209.85.214.42]:34808 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754851Ab3DTKpd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Apr 2013 06:45:33 -0400
Received: by mail-bk0-f42.google.com with SMTP id jc3so2048114bkc.1
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 03:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bee.kz; s=beekz;
        h=x-received:content-type:mime-version:subject:from:in-reply-to:date
         :cc:content-transfer-encoding:message-id:references:to:x-mailer;
        bh=cQMHhie1tZgDdRgM6klCPifqx7/Blvfa4bfAhsX1u7Q=;
        b=mmskD6Va56ko04SeyrinHLSQ8YcjvvK6B1JyanmepOX5hxpE3MfnzDxUqTFAR42CzK
         PDcZ54B3erNEU+BK/Cw585pFoq/R/Q5Xx8p9lJouAFhutAIPM/cFYyTVT38g+N1h9ERE
         d8x0NVHM/IsWW5ZgZR8/oD/+8dIp1eDZPDItU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:content-type:mime-version:subject:from:in-reply-to:date
         :cc:content-transfer-encoding:message-id:references:to:x-mailer
         :x-gm-message-state;
        bh=cQMHhie1tZgDdRgM6klCPifqx7/Blvfa4bfAhsX1u7Q=;
        b=k8agPX2jNV9SN1q6s7UJGZFCVQkjZ2WiGWxfZ+HlzQNcPzYKFAnZqWrl6Trw6ZKkyi
         6o0XBQVxJmFKo5UnidoODd0yqOlc4u6BNtrhVTWz/BwOJ/H0kWzdg9FHCqcbfJt5hLCj
         mo1/O5oyzwYSScG3604hgZjUysjsbbVw76eBz1I/yv2l8gy3wjEMcYTaStzs4IOP3g+l
         C7NMn53lHU/g8ETpfOpVWSC3Ird5x2aLV05WxeAqb2wDfeh85Tp1fHXxo0N0lKL095rH
         7fT8LQ7+prJCy6Z8BHIG3uSbSNgpzmDCkAceIQZUvhhwg9IMS+JM/KMh26xXU+8kL22C
         8giQ==
X-Received: by 10.205.19.74 with SMTP id qj10mr7123155bkb.61.1366454731065;
        Sat, 20 Apr 2013 03:45:31 -0700 (PDT)
Received: from [192.168.1.8] ([2.135.60.90])
        by mx.google.com with ESMTPS id fs20sm4774785bkc.8.2013.04.20.03.45.28
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Apr 2013 03:45:29 -0700 (PDT)
In-Reply-To: <20130420031955.GA30856@iris.ozlabs.ibm.com>
X-Mailer: Apple Mail (2.1503)
X-Gm-Message-State: ALoCoQkQjJLNu7rplHaEZ8vsqub0CecnE+4AsJ/zJ/GOrH6KY0Z2FZzbaQ6K29bkgaZRxCp6b417
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221843>


On Apr 20, 2013, at 9:19 AM, Paul Mackerras <paulus@samba.org> wrote:

> On Thu, Apr 11, 2013 at 01:02:48AM +0600, Tair Sabirgaliev wrote:
>> On OSX Tcl/Tk application windows are created behind all
>> the applications down the stack of windows. This is very
>> annoying, because once a gitk window appears, it's the
>> downmost window and switching to it is pain.
>> 
>> The patch is trivial: if we are on OSX, emulate Cmd-Shift-TAB
>> key event, so that the gitk application window is brought
>> from bottom to top.
> 
> Is this really the only way to do it?  It seems a bit hacky to me.  I
> would think you should be able to use the "wm" command to achieve what
> you want.  I don't use Mac OS, so I don't know exactly how Tcl/Tk
> behaves on it, but this page looks like it might hold some clues for
> what you want to do:
> 
> http://teapot.activestate.com/package/name/windowlist/ver/1.4/arch/tcl/file.tm

Today I did some further investigations on reasons app windows going behind. 
Turns out this is not something specific to Tcl/Tk. 

On OSX, GUI applications can be launched from Terminal in 2 ways:
1. Interactively, directly using app executable:
         sh$ /Applications/Chess.app/Contents/MacOS/Chess
2. Asynchronously, using OSX 'open' facility
         sh$ open -a Chess

The problem with 1st way is that OSX always puts the new app window behind 
the others, thus making sure the focus remains at Terminal input. 

The problem with the 2nd approach is that app is launched 'asynchronously', 
detached from Terminal, so when you close the app, focus doesn't necessarily 
return back to Terminal as it would normally do in Linux for example.

So, yes, this is a really hacky workaround, but it consistently takes the interactively 
launched app window to foreground on most modern OSX versions.

And regarding the link you provided -- I tried them, unfortunately the techniques 
there don't bring the application to foreground. Looks like they are mostly intended
to manipulate windows within a single multi-window application.

Tair.