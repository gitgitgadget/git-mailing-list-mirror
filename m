From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: regression: request-pull with signed tag lacks tags/ in master
Date: Fri, 16 May 2014 00:39:25 +0300
Message-ID: <20140515213925.GI1699@redhat.com>
References: <20140515163901.GA1403@redhat.com>
 <xmqqzjiiev1a.fsf@gitster.dls.corp.google.com>
 <xmqqr43uetyp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 15 23:40:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl3OI-0005Jt-LV
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 23:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756062AbaEOVke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 17:40:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49268 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754051AbaEOVke (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 17:40:34 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s4FLeWuR014822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2014 17:40:32 -0400
Received: from redhat.com (ovpn-116-58.ams2.redhat.com [10.36.116.58])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s4FLeU9V019495;
	Thu, 15 May 2014 17:40:31 -0400
Content-Disposition: inline
In-Reply-To: <xmqqr43uetyp.fsf@gitster.dls.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249204>

On Thu, May 15, 2014 at 12:13:18PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > "Michael S. Tsirkin" <mst@redhat.com> writes:
> >
> >> looks like pull requests with signed git got broken in git master:
> >>
> >> [mst@robin qemu]$ /usr/bin/git --version
> >> git version 1.8.3.1
> >> [mst@robin qemu]$ git --version
> >> git version 2.0.0.rc1.18.gac53fc6.dirty
> >> [mst@robin qemu]$ 
> >> [mst@robin qemu]$ /usr/bin/git request-pull origin/master git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git for_upstream |grep git.kernel.org
> >>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >>
> >>
> >> [mst@robin qemu]$ git request-pull origin/master git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git for_upstream |grep git.kernel.org
> >>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git for_upstream
> >>
> >> this for_upstream syntax is a problem because it does not work
> >> for older git clients who might get this request.
> >>
> >> Didn't bisect yet - anyone knows what broke this?
> >
> > Linus ;-)  The series that ends with ec44507, I think.
> 
> My reading of the earlier parts of the series is that Linus wanted
> us never dwim "for-upstream" to "tags/for-upstream" or any other ref
> that happens to point at the same commit as for-upstream you have.
> The changes done for that purpose covered various cases a bit too
> widely, and "request-pull ... tags/for_upstream" were incorrectly
> stripped to a request to pull "for_upstream", which was fixed by
> 5aae66bd (request-pull: resurrect "pretty refname" feature,
> 2014-02-25).
> 
> But that fix does not resurrect the dwimming forbid by the earlier
> parts of the series to turn "for_upstream" into "tags/for_upstream".
> 
> What would you get if you do this?
> 
>     $ git request-pull origin/master \
>       git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git \
>       tags/for_upstream | grep git.kernel.org


I get
 git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
