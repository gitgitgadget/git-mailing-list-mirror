From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v20 43/48] refs.c: move the check for valid refname to lock_ref_sha1_basic
Date: Wed, 20 Aug 2014 14:47:08 -0700
Message-ID: <CAL=YDWkfMMqYdOVWfBJkMncPnm8GwMdd1q4ipD_Y_r-nBet+2w@mail.gmail.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
	<1403275409-28173-44-git-send-email-sahlberg@google.com>
	<53BC07FC.8080601@alum.mit.edu>
	<20140715180424.GJ12427@google.com>
	<CAL=YDWkYAg-0h3ZwiyZGtUHFEv1KEti_uURTwgbZE9xT_P_XSQ@mail.gmail.com>
	<CAL=YDWmc2gkw=8YavWHyLUAD4du7saPrKzPKT+dsCfdZJz1EiA@mail.gmail.com>
	<53F4B642.7020002@alum.mit.edu>
	<xmqqk363t060.fsf@gitster.dls.corp.google.com>
	<53F500E9.6060900@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Aug 20 23:47:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKDit-0006aJ-Sm
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 23:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026AbaHTVrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2014 17:47:10 -0400
Received: from mail-vc0-f170.google.com ([209.85.220.170]:45534 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618AbaHTVrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2014 17:47:09 -0400
Received: by mail-vc0-f170.google.com with SMTP id lf12so9922856vcb.29
        for <git@vger.kernel.org>; Wed, 20 Aug 2014 14:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fHDntcPtNEnl1NujguQosuzINL18zgkUP4cx0MkkGaY=;
        b=CWUmi4+1L3t8vEQMmc9943uw+U8Z+yM3A8UdWC/pfEv+m9tpxe3fdWyzFVxxQ44chz
         4kdr7bH5HwzkMSSalPZKw+5MsCQTG49chKpMwmhIpR+1s4tFNWf8L90qbCFFp5wRHWya
         kHnN6y0ofnsg4KTs2nY0vFGDcSEc4i3xmI44Md43cCnuvpUOKSAtk+cv+/ew9aA37nCV
         LyPt7Ll68z41rpetA+ma+j99sD1/zPxxY0jlncRCX16E5/ahj3P658SYDzHWF5bwpHud
         Ih1N/puKy2yqo2SviRCIadCIMPg6+LsVSWS6lar8UB17Oarxt+10thfAufEBxCiTWjTc
         vlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=fHDntcPtNEnl1NujguQosuzINL18zgkUP4cx0MkkGaY=;
        b=dKezgtcupYoncQmgpjbeqxxXYQ+5qKZO9Y8xaqQZjzsDLueoGI2dcqnWsnCe79Qah2
         7Sl4FO7l8fZJMUXuNSXAVUTkNImW/ZrXr+x5nNicfYULqAAAaTWHZ+lgtV7oeJEG6oh+
         umVdUMruQVd/OOa+CrQ7gw5mpoRNbHG20OjuN+yYHum0kiorjai9Nui3Pk7g1apcup3F
         NaWACEOtEbEop0iUds8RJGSZ5tuWL9HihLuzAjn2IgGEsYKUSIiY+M46PI3BNcGa1irC
         77I4S7x3EENB4XKo11wHaqQQQrCWKAYEj9iVnip/WkfK2SuY0dwQImBQbfTs9Sgqml+Z
         6KEw==
X-Gm-Message-State: ALoCoQmTFaDDY0qWrv/n+8TlhHq76mWI6ENPyzmBWew7eGbLIKvhStKhKPMrgtrHjzgNK7lYB5x5
X-Received: by 10.220.200.71 with SMTP id ev7mr38506465vcb.24.1408571228241;
 Wed, 20 Aug 2014 14:47:08 -0700 (PDT)
Received: by 10.52.69.136 with HTTP; Wed, 20 Aug 2014 14:47:08 -0700 (PDT)
In-Reply-To: <53F500E9.6060900@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255590>

On Wed, Aug 20, 2014 at 1:11 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 08/20/2014 09:45 PM, Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>
>>> I think we can get away with not including broken refnames when
>>> iterating.  After all, the main goal of tolerating them is to let them
>>> be deleted, right?
>>
>> Or read from a ref whose name has retroactively made invalid, in
>> order to create a similar but validly named ref to serve as its
>> replacement?  So at least we need to give the users some way of
>> reading from them, in addition to deleting them, no?
>
> The die() error message would presumably include the name of the invalid
> reference.
>
> If we change the rules for reference names and a bunch of names become
> invalid, then it would admittedly be cumbersome to run git N times to
> find the N invalid names.  But if we change the rules, then *at that
> time* we could always build in iteration over broken reference names.
>
> It's not that I have something against building it iteration over broken
> reference names now, as long as it is clearly segregated from "normal"
> iteration to prevent illegal names from getting loose in the code.

We already have iterators that show also bad refs.
For example, git branch uses
DO_FOR_EACH_INCLUDE_BROKEN
which is a flag to include also broken refs that can not be resolved
which allows them to be listed :



$ echo "this is not a valid sha1" >.git/refs/heads/broken
$ git branch
  broken
  foo
* master
$ git branch -D broken
error: branch 'broken' not found.

(allowing -D to remove it is in a different patch further down my series)


Since we already display broken/unresolvable refs, I think the most
consistent path is to also allow showing the refs broken/illegal-names
too in the list. (when DO_FOR_EACH_INCLUDE_BROKEN is specified)
Of course, an end user could fix this by deleting the file but since
it is easy to add the special casing to 'git branch -D' to handle this
case I think this would be more userfriendly since then the user can
use git branch -D regardless of the reason why the ref is broken.


Ronnie
