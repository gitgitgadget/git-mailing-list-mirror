From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] merge-file: consider core.crlf when writing merge
 markers
Date: Sun, 24 Jan 2016 11:44:34 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601241143090.2964@virtualbox>
References: <cover.1453482052.git.johannes.schindelin@gmx.de> <c0c775ea7a9ba3244748b784241de685cefc73b1.1453482052.git.johannes.schindelin@gmx.de> <xmqqmvrxv5tn.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1601221937440.2964@virtualbox>
 <xmqqa8nxv3do.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Beat Bolli <dev+git@drbeat.li>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 11:45:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNIAB-0003El-Nf
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 11:44:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbcAXKow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 05:44:52 -0500
Received: from mout.gmx.net ([212.227.17.22]:49994 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314AbcAXKov (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 05:44:51 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lwoiq-1a3Oph1XMe-016Rbm; Sun, 24 Jan 2016 11:44:37
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqa8nxv3do.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:44C2HZq5+VJEAvt0H5srEa2NhHbUJzSRqXIM9YYc2t5J/8+O0mA
 ipeGC1z2LfcwnNauqSgUA1IMSCjIwY1npsd5z7KurHO6E7NxHKGbtocVjmECW+PxFSKCl8w
 ZRg+PYyadiisMdGpF81sJ3OZfSuwV4ktTlz10o4YyaBnR4pixdQ2lzznX0u4eRBXsUYJffw
 nfDLm1Qo6l3GpVjsKJs4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6C0w5MQnI4g=:46MyF3nE47HjA05G3B0nx3
 /1n6m7xgZxQ9dtZc00A5vOx0xefYkq5gnggedCK+YdVFLrhzOXawd7zQvP17QcyK1slC131TA
 aDgFIvrabmS9Pjoxcfy5Esx91PmMhepm+ZHNoayB0yfeREGj49CihvNRTmtx73JUv8R+l4TXq
 ELUVDeW+4Gio5C5gasVJDXQGm9pu6164MNkHrsNgxwenmlf8NzfYKIJKO4NLzo5loG20DKLWZ
 XSncviX2GCIiA0Q6TVH8NBDfd8jtwEXaXZf67ro87bqWjiYvuJX/exSAe83oMqIlTV1GQMRq3
 pDAe7MgRNzyAvjt8lQXb5umOyzYICj7K8Ti+o8CJ/9auqJ6pHU4NF0inSKUQs8izry1+KT056
 MBfLOydtCJ/5RP11g7wo1BpXWEMlq4uUQvTzW/m/57cdm0bAgGmo7e6zrdfR5ewUpceH0QhQa
 3Xge/1+z8Tq0UcQ74+1MhxPdGw4glP9t1SaQgztv/Se7uSDm5biqsx29jT/LPQLQdGw2ea5oX
 ghYlxY0mCY7AKADP7wMPbYQRYBYLE2f5Yvp+rb0SLIzJGUb9oArT1Jr8W7AjnXSlb0LwWB3cU
 yuXNHOPWLqmdS7QRUPzgSgWji9sCjo8fULE3Y1aX0ynvLY3r0+eZS2ql0qIsKreAXYGYlqRe9
 DUSHgCOBd051Vdm/5yV2n0j2OFQ7SRksbhlWB8C/K+3bFR9gKhCR9hKK1npS7ejSK7vmtlJyz
 BI3M3XnFf65/sf7MTqjR1EdECQb7xG5flsFYcZxtNbf7CajE5Q+LKQmGHn95e9stIK2DjM1D 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284642>

Hi Junio,

On Fri, 22 Jan 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> > It is the duty of ll_merge()'s *caller* (in case of Git's `merge`
> >> > command, the merge_content() function) to convert the merge result
> >> > into the correct working file contents, and ll_merge() should not muck
> >> > with line endings at all.
> >> 
> >> Hmph, aren't there people who use CRLF throughout their set-up (that is,
> >> it is normal for both of their blobs and working tree files to use CRLF
> >> line endings)?  Or is such a setting illegal and unsupported?
> >
> > Good point.
> >
> > While I would love to simply not support such a case, it would be turning
> > a blind eye to reality.
> >
> > So I guess I need another patch like this (plus a test case):
> >
> > -- snipsnap --
> > t a/ll-merge.c b/ll-merge.c
> > index 0338630..4a565c8 100644
> > --- a/ll-merge.c
> > +++ b/ll-merge.c
> > @@ -111,6 +111,7 @@ static int ll_xdl_merge(const struct ll_merge_driver
> > *drv_unused,
> >  		xmp.style = git_xmerge_style;
> >  	if (marker_size > 0)
> >  		xmp.marker_size = marker_size;
> > +	xmp.crlf = eol_for_path(NULL, src1->ptr, src1->size) == EOL_CRLF;
> >  	xmp.ancestor = orig_name;
> >  	xmp.file1 = name1;
> >  	xmp.file2 = name2;
> 
> What I do not understand is that you already had xmp.crlf even the
> log message claimed that the caller is supposed to feed LF blobs and
> the ll_merge() shouldn't have to worry about this.

Well, I just heeded your point about blobs not necessarily having LF-only
end-of-lines ;-)

In any case, the upcoming iteration works quite a bit differently, and I
want to add, robustly.

Ciao,
Dscho
