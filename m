From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v20 43/48] refs.c: move the check for valid refname to
 lock_ref_sha1_basic
Date: Fri, 22 Aug 2014 14:41:05 +0200
Message-ID: <53F73A61.1010606@alum.mit.edu>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>	<1403275409-28173-44-git-send-email-sahlberg@google.com>	<53BC07FC.8080601@alum.mit.edu>	<20140715180424.GJ12427@google.com>	<CAL=YDWkYAg-0h3ZwiyZGtUHFEv1KEti_uURTwgbZE9xT_P_XSQ@mail.gmail.com>	<CAL=YDWmc2gkw=8YavWHyLUAD4du7saPrKzPKT+dsCfdZJz1EiA@mail.gmail.com>	<53F4B642.7020002@alum.mit.edu>	<xmqqk363t060.fsf@gitster.dls.corp.google.com>	<53F500E9.6060900@alum.mit.edu> <CAL=YDWkfMMqYdOVWfBJkMncPnm8GwMdd1q4ipD_Y_r-nBet+2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 14:48:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKoGM-0005fy-TN
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 14:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756143AbaHVMsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 08:48:11 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:52987 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756026AbaHVMsK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Aug 2014 08:48:10 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Aug 2014 08:48:10 EDT
X-AuditID: 1207440c-f79036d000005e77-96-53f73a649ae7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 1B.D0.24183.46A37F35; Fri, 22 Aug 2014 08:41:08 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB020B.dip0.t-ipconnect.de [93.219.2.11])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s7MCf5dY017866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 22 Aug 2014 08:41:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <CAL=YDWkfMMqYdOVWfBJkMncPnm8GwMdd1q4ipD_Y_r-nBet+2w@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsUixO6iqJti9T3YoO0kr0XXlW4mi4beK8wW
	b28uYbT4N6HGgcVj56y77B4LNpV6XLyk7PF5k1wASxS3TVJiSVlwZnqevl0Cd8aFjh72gvMC
	FbeWRjcwHuftYuTkkBAwkfh+9j8LhC0mceHeejYQW0jgMqPEyt2uXYxcQPZZJonptz+CFfEK
	aEt8nbiGvYuRg4NFQFXi2TwtkDCbgK7Eop5mJhBbVCBIYvbneewQ5YISJ2c+AWsVEdCUuNl/
	mglkJrNAE6PEw10nwJYJCyRIXO04yQqx7B+zxPenUxlBEpwCgRJXFzxkA1nGLKAusX6eEEiY
	WUBeYvvbOcwTGAVmIdkxC6FqFpKqBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0DfVyM0v0
	UlNKNzFCwphnB+O3dTKHGAU4GJV4eE+Yfw8WYk0sK67MPcQoycGkJMq71RIoxJeUn1KZkVic
	EV9UmpNafIhRgoNZSYS3yhQox5uSWFmVWpQPk5LmYFES51Vdou4nJJCeWJKanZpakFoEk5Xh
	4FCS4O0CGSpYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPitL4YmCcgqR4gPa6g7Tz
	Fhck5gJFIVpPMSpKifP+swBKCIAkMkrz4MbCktMrRnGgL4V5w0DaeYCJDa77FdBgJqDB02d8
	BRlckoiQkmpgNI5zunPpjMcc54btJn3GrqGX409uaKlRieKcZZTVUdL6z2t1r/F909/xzn7b
	7aWn2C7Nz3305wCjGAOrBOOKVbv+rG+O3HOKt1z09N1ViwLe3qnx/n104i8d3zdH 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255667>

On 08/20/2014 11:47 PM, Ronnie Sahlberg wrote:
> [...]
> Since we already display broken/unresolvable refs, I think the most
> consistent path is to also allow showing the refs broken/illegal-names
> too in the list. (when DO_FOR_EACH_INCLUDE_BROKEN is specified)
> Of course, an end user could fix this by deleting the file but since
> it is easy to add the special casing to 'git branch -D' to handle this
> case I think this would be more userfriendly since then the user can
> use git branch -D regardless of the reason why the ref is broken.

My concern with this idea is that some code relies on at least some of
the reference name constraints for its proper functioning; for example,

* The ref caching code would likely be confused by ill-formed refnames
like "refs/heads//foo" or "/refs/heads/foo" or "refs/heads/foo/".  (I
understand that such references cannot exist as loose refs, but they
could be represented in the packed-refs file.)

* Any code that might try to read or write a loose reference would
likely be confused by "refs/heads//foo" or "refs/heads/./foo" or
"refs/heads/../foo" or "/refs/heads/foo" or "refs/heads/foo/".  On
Windows there might also be problems with "refs/heads\foo" or
"d:refs/heads/foo" or "prn:refs/heads/foo" or "//refs/heads/foo".

* The locking code could easily be confused by a reference named
"refs/heads/foo.lock".

So to the extent that we loosen the checks on refnames when they are
read, we would have to re-vet any code that touches them to make sure
that it doesn't break in a horrible (and possibly security-compromising)
way.  This is why I would prefer to quarantine broken reference names in
the smallest possible part of the code.

I *think* that the biggest problems would be related to reference names
that do not map straightforwardly to relative filenames, so an
alternative would be to do some minimal checks in any case, but make it
possible to turn off the stricter checks (those that mostly exist to
make reference expression parsing possible) when necessary.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
