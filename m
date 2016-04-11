From: Jason Vas Dias <jason.vas.dias@gmail.com>
Subject: clone hang prevention / timeout?
Date: Mon, 11 Apr 2016 22:49:19 +0100
Message-ID: <CALyZvKwxE4T8-FmEYgPMgAFKLmeAY5f-y-mDL8S9twTb0umRaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 11 23:49:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apji2-0001Pk-Jc
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 23:49:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754773AbcDKVtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2016 17:49:22 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:33525 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191AbcDKVtV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2016 17:49:21 -0400
Received: by mail-wm0-f54.google.com with SMTP id f198so163282020wme.0
        for <git@vger.kernel.org>; Mon, 11 Apr 2016 14:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=Sk1M3pyRgQC7fvO3bLEGkEY0TSpa8WL/oY2wU4zUJhw=;
        b=oagOC8xr8CLJcXDGxsx1+dPBst2mzPiHmLBVrHk91vCOjin7+EITKxfSLloNGaXnMz
         gPHfVRpTDoFK1VlFIIFHQjHhnx+ROXtRFPcOVkHmMMHmGP005HWrYlV1E0KneXi+6Bt3
         LnDiQ4EpHKwR0SrNPt8zgHBtIlOHRr7QslNyL5rA5LZbyHiQOQITVlZq5cSlRNJB/4kr
         Xg+VwyYq7tc1VMZt7u2VKgaTd2SktQUZ5xGZ34o0LsNH6lp5IFByHrxLrYPIZ63Z6UIS
         4FRZLfSSrsjTfPUAdVR1K7R3J4EXsrFJDcHgufwJeKZ26vqJQKaZKJNm5sUIGpynei5j
         Lsjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Sk1M3pyRgQC7fvO3bLEGkEY0TSpa8WL/oY2wU4zUJhw=;
        b=L/8cjA2G2pcwHMD1YREu3V0BJneWlZovF+XQjp+74/MIU/eVzeuRffKBlX9AaSl9DI
         6I8Lc1l2/sXtGCbKhtN9szViu4VlaMwnhuRmHBnKNhIkUWf30IVbQj+tfPB9Kj2G91ZR
         b7vJfgbpQLKLNIil+ep2K8tSDJDlqbr/UdRwzGaojibsDI8hyDZYngdkb4l86bDUbaIX
         SJ4hN3iBrk/o7DI8mzzA9hpQbGnccvjGh+d2H9gzCma+GCk3vjp663uHRkJVSGhW7uHx
         HR6Rq8LcUctZIkbxcM3c8Jo7n5zLudYXhCUnIN7E6P0QunvPu6jNw/53N0gcDGJBhCbW
         edUg==
X-Gm-Message-State: AD7BkJKU6qRHOmsX7LHOq6xz/zMz54UaKT9xUuQtbiKpdkdI2DYzQmnVEJjG2CzTQawulPmYDHGkbSTdW/xFzQ==
X-Received: by 10.28.218.145 with SMTP id r139mr21972208wmg.52.1460411359867;
 Mon, 11 Apr 2016 14:49:19 -0700 (PDT)
Received: by 10.28.234.70 with HTTP; Mon, 11 Apr 2016 14:49:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291234>

It appears GIT has no way of specifying a timeout for a clone operation -
if the server decides not to complete a get request, the clone can
hang forever -
is this correct ?
This appears to be what I am seeing, in a script that is attempting to do many
successive clone operations, eg. of
git://anongit.freedesktop.org/xorg/* , the script
occasionally hangs in a clone - I can see with netstat + strace that the TCP
connection is open and GIT is trying to read .
Is there any option I can specify to get the clone to timeout, or do I manually
have to strace the git process and send it a signal after a hang is detected?
