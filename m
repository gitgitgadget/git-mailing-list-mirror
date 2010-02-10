From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 8/6] receive-pack: Send internal errors over side-band
	#2
Date: Wed, 10 Feb 2010 09:17:08 -0800
Message-ID: <20100210171708.GF2747@spearce.org>
References: <1265767290-25863-1-git-send-email-spearce@spearce.org> <1265767290-25863-2-git-send-email-spearce@spearce.org> <4B725CB1.1080908@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Feb 10 18:24:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfGJ0-0008Re-HP
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 18:24:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755908Ab0BJRXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 12:23:55 -0500
Received: from mail-yw0-f173.google.com ([209.85.211.173]:42441 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755848Ab0BJRXy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 12:23:54 -0500
Received: by ywh3 with SMTP id 3so262705ywh.22
        for <git@vger.kernel.org>; Wed, 10 Feb 2010 09:23:53 -0800 (PST)
Received: by 10.150.208.17 with SMTP id f17mr2807183ybg.185.1265822231958;
        Wed, 10 Feb 2010 09:17:11 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm526423yxe.1.2010.02.10.09.17.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Feb 2010 09:17:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B725CB1.1080908@viscovery.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139523>

Johannes Sixt <j.sixt@viscovery.net> wrote:
> Shawn O. Pearce schrieb:
> > +static void rp_error(const char *err, ...) __attribute__((format (printf, 1, 2)));
> > +static void rp_warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
> > +
> > +static void report_message(const char *prefix, const char *err, va_list params)
> > +{
> > +	int sz = strlen(prefix);
> > +	char msg[4096];
> > +
> > +	strncpy(msg, prefix, sz);
> > +	sz += vsnprintf(msg + sz, sizeof(msg) - (sz + 1), err, params);
> > +	msg[sz++] = '\n';
> 
> This writes beyond the buffer if it is too small because the return value
> tells how many characters *would* have been written if it were
> sufficiently large, no?

Ugh.  I don't code C often enough anymore.

Thank you for catching that.

 
> > +static void rp_warning(const char *err, ...)
> > ...
> > +static void rp_error(const char *err, ...)
> > ...
> 
> Looks like we need set_report_routine().
> 
> Or did you replace only selected error() and warning() calls by rp_error()
> and rp_warning()?

As described by others in the thread... I only replaced selected
calls.  Well, most of them, maybe too many.  But I didn't want to
expose everything to the client.  So I added new functions.  Yes, it
was painful.  I wasn't happy about it.  But I also wasn't happy about
exposing every message to the client over the side-band channel.

-- 
Shawn.
