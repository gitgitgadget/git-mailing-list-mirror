From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/6] GITWEB - Load Checking
Date: Fri, 11 Dec 2009 11:09:16 +0100
Message-ID: <200912111109.17047.jnareb@gmail.com>
References: <1260488743-25855-1-git-send-email-warthog9@kernel.org> <m34onye3h8.fsf@localhost.localdomain> <4B21AC4D.2020407@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: "J.H." <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 11 11:08:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJ2Q5-0005Qt-OH
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 11:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756349AbZLKKH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 05:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756317AbZLKKH4
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 05:07:56 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:50046 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756292AbZLKKHz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 05:07:55 -0500
Received: by fxm21 with SMTP id 21so803916fxm.1
        for <git@vger.kernel.org>; Fri, 11 Dec 2009 02:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=SBkt3QHmwcMhrB0MbKa6NtM5FKA8P/Od2GxGPmfKENQ=;
        b=TR9xsBauXBSzBahf70IdiUCP8HprkuCUKfjxI4oldZkOq4bzdH62c50TJW4tDi0Qbf
         kENEkGZlJn2M2Mzd+PCjIB8GxuzTdx246G6GpiIJXeO5u4wB5Sw0AjRStTxuG2SA31a6
         TFfsL913nuzMVCxIQf/qcFzUJo9QqJC4s6xZU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=m85+CRFyVFSy23QY+1Ow/4LjzDElYLf6H211fwEtNneQAJdRS73Grzz6zfVjNgGRFW
         dkKPQYnarqH3EL02ozSF2KNgLiUUO0+fBdfetOOXHU1MppD6RV90Gb7WZiW/127x25mq
         kMo3Fg/GN4oXkAxHC71kUZG+uBEoCcNx3Xm6M=
Received: by 10.223.17.65 with SMTP id r1mr1264840faa.5.1260526080611;
        Fri, 11 Dec 2009 02:08:00 -0800 (PST)
Received: from ?192.168.1.13? (abvy165.neoplus.adsl.tpnet.pl [83.8.222.165])
        by mx.google.com with ESMTPS id c28sm2491451fka.49.2009.12.11.02.07.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 11 Dec 2009 02:07:58 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4B21AC4D.2020407@kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135075>

On Fri, 11 Dec 2009, J.H. wrote:
> <snip>
>>> adds $maxload configuration variable.  Default is a load of 300,
>>> which for most cases should never be hit.
>> 
>> Your patch doesn't allow for *turning off* this feature.  Reasonable
>> solution would be to use 'undef' or negative number to turn off this
>> check (this feature).
> 
> Well there's the opposite argument that setting the number arbitrarily 
> high, 4096 for instance would also in essence negate this (though I'll 
> admit I've reached and exceeded those numbers before)
> 
> That said I agree, being able to turn this off needs to be added and 
> will be shortly.

Simplest solution would be to used 'undef' (undefined value) for 
"turned off", i.e.:

  if (defined $maxload && get_loadavg() > $maxload) {

>>> Please note this makes the assumption that /proc/loadavg exists
>>> as there is no good way to read load averages on a great number of
>>> platforms [READ: Windows], or that it's reasonably accurate.
>> 
>> What about MacOS X, or FreeBSD, or OpenSolaris?
> 
> Will comment on this further down

I think it would be better to write in commit message that because finding
load average is OS dependent, there is provided (sample) solution which
uses /proc/loadavg and works (at least) on Linux.  And that for platforms
which do not have /proc/loadavg the feature is simply turned off (by the
way of using load=0 if load cannot be determined).
 
>> You should mention that it is intended that if gitweb cannot read load
>> average (for example /proc/loadavg does not exist), then the feature
>> is turned off, i.e. the check always succeeds.  Which is reasonable.
> 
> That's fine.

See above proposal.  This information should be present in commit message,
and perhaps maybe even as one-line comment above opening /proc/loadavg.

>>> +# loadavg throttle
>>> +sub get_loadavg() {
>>> +    my $load;
>>> +    my @loads;
>>> +
>>> +    open($load, '<', '/proc/loadavg') or return 0;
>> 
>> Why not use one of existing CPAN modules: Sys::Info::Device::CPU,
>> BSD::getloadavg, Sys::CpuLoad?
> 
> Here's the fundamental problem:
> 
> Sys:Info:Device:CPU
> 	Windows:
> 		Using this method under Windows is not recommended
> 		since, the WMI interface will possibly take at least 2
> 		seconds to complete the request.
> 
> BSD::getloadavg
> 	While this more or less supports anything with a libc getloadavg
> 	(and thus might be the best one I've seen, I'll admit I didn't
> 	notice this one when I looked years ago) getting it to work on
> 	windows looks, exciting.
> 
> Sys::CpuLoad:
> 	http://cpansearch.perl.org/src/CLINTDW/Sys-CpuLoad-0.03/README
> 	Specifically:
> 		- Currently FreeBSD and OpenBSD are supported.
> 		- Wanted: HPUX 11.11 ...
> 		- Todo: Win32 support
> 
> 	So this doesn't really buy me anything but, maybe, BSD support.
> 	
> So at the end of the day, none of those really gets me a "useful" cross 
> platform load checker (though like I said BSD::getloadavg looks to be 
> the best of the ones you mentioned) and more or less Windows is going to 
> lose this as a usable feature no matter what.
> 
> I think I'd almost rather set this up so that if it can't get something 
> useful (I.E. /proc/loadavg is missing) it just skips past it as if the 
> load was 0.
> 
> I might try out the BSD::getloadavg but I want to take a look and see if 
> that's easily installed or not, if it's not it might be difficult to 
> justify that as a dependency.

After thinking about this a bit, now I don't think that it is terribly
important.  You *might* describe alternate approaches (roads not taken)
in commit message, but requiring /proc/loadavg for the feature to work
is fine for first patch (it makes patch simpler).

>>> +if (get_loadavg()> $maxload) {
>>> +    print "Content-Type: text/plain\n";
>>> +    print "Status: 503 Excessive load on server\n";
>>> +    print "\n";
>>> +    print "The load average on the server is too high\n";
>>> +    exit 0;
>> 
>> Why not use die_error subroutine?  Is it to have generate absolutely
>> minimal load, and that is why you do not use die_error(), or even
>> $cgi->header()?
>> 
>> Wouldn't a better solution be to use here-doc syntax?
>> 
>> +    print <<'EOF';
>> +Content-Type: text/plain; charset=utf-8
>> +Status: 503 Excessive load on server
>> +
>> +The load average on the server is too high
>> +EOF
>> +    exit 0;
> 
> It was intended to be the most minimal possible, mainly get in, get out. 
>
>   Also not sure the die_error existed in gitweb when this was originally 
> written.  Probably worth switching to it now since it's there either 
> way, and I don't think using it would add enough overhead to matter.

Well, if you are not worring excessively about overhead, then I think
using die_error would be the best solution, as it would preserve look
of gitweb.  It would require extending die_error by 503 response, or
rather %http_responses hash and comment above die_error.

Also I think that Status: should be before Content-Type: header (but
probably it is not required by the standard).

-- 
Jakub Narebski
Poland
