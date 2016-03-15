From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC/GSoC 09/17] rebase-common: implement
 cache_has_unstaged_changes()
Date: Tue, 15 Mar 2016 12:51:29 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603151249570.4690@virtualbox>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com> <1457779597-6918-10-git-send-email-pyokagan@gmail.com> <alpine.DEB.2.20.1603142151230.4690@virtualbox> <xmqqoaag9177.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Paul Tan <pyokagan@gmail.com>, Git List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>, sam.halliday@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 12:51:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afnVu-0007nV-Br
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 12:51:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933936AbcCOLvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 07:51:47 -0400
Received: from mout.gmx.net ([212.227.15.19]:53941 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932428AbcCOLvp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 07:51:45 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MC4R6-1aWxox0BCC-008qoJ; Tue, 15 Mar 2016 12:51:31
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqoaag9177.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:ifXzFH9Q7DyGAogNX4bnC/vgxJN2iwhvkD2eZMS4r/bxhRL2afZ
 4dlDBMLFfUqg9nysZk3K6kYln0ZVwLFojFORsIGtn7HYiRSdTTRSQX4Oc3TYJs46w7Nt3SA
 1jUtoOwFiaXBIEU6EkHdLnK6D1pOeUbW5ugrgtcfeeROYgpVOv917aB4ikKv/tuSd3J+bLN
 EpPIzjlutpcPHwEBGLabw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uOcLdIy5JVI=:x5pVrX6Vst4mhlWb32e+qP
 c4IG/fV5f+H+ZFJyXc82nlBn13dsQJu36WhW+z7bIMhmFYxUxb8/STFHvSHz+Ph1EncuzVFyy
 WOd7X8wKaow+2Lzvz9RQ6DlMAoWe1Zf6Oa3RDeH2Wj0zJpUM+dCPZLKGWAGz+d20l4HsVk84w
 6C43ecUxOLo6di0YtAyaj0lCqeGDfTCAkVmONMZkj86pZCUthzuyq4kcxB5PkRDjnwlTLijKG
 LVjC5PIvaP5HgfYFoG7x2NeFvX8xVo8lcRMFZHKgKPNmtrfYaVFRR6i/xE/hWMco1hMcK7+WL
 KgIajNCehFYypiFN34xqPxY7Ueb8/vn1bKofaxWbOUPu2WBm0xpgu51P/wJHa672zbTn2J6dP
 MHYjAy4bmZSXdyTEBL6vSej6wXr62MsPREqz22Fizga05fkXUyzqqTxJULKlhOtmIlNgxNb01
 pIm8aaP8ITeN9wVBwMWmXtDndFpTyBuWPrI6msi7UkjzgDCswVtvHQls92aymFhcXl4+nTW/d
 UZUXjgveO5qARM4NPmd2O3w05uT4XC/+Ed6nHCDk+qa+UEJTt/dDz5bkIcvm5sXxT7Dxgz/C8
 1OeYK7vUrzAbeZovn+njt2nwDNzzvV4c9nPAIRwlCkEkn3xN5W7agVaM2/x97Y2pfOG33UtOd
 Fn+4O0+bHUAR4Q5moZ9gkUIF+luu7Zt6t6C0dEYIqQzNBoQOt39Ou+WmBmLwRvqq7LYjUwcfF
 FWzsnw4e7bZdwbaDre1PYMelTMCtASksKTJCPKTzDc1wNk8KacuCY3vn0ZYfYMXA5MMedyBl 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288848>

Hi Junio,

On Mon, 14 Mar 2016, Junio C Hamano wrote:

> If the [has_uncommitted_changes()] function will be made a public helper
> that may be called by anybody, a possible error reporting mechanism
> would be to give a list of modified paths to the caller that asks them,
> and have the caller apply its own "prefix" processing to make them
> relative.

But the point of the has_uncommitted_changes() is to figure out as fast as
possible whether there are uncommitted changes, not the exact list. In
fact, we want to return with a "yes" as soon as we encounter the first
uncommitted change.

Ciao,
Dscho
