From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 12/21] refs: allow log-only updates
Date: Thu, 11 Feb 2016 11:03:56 +0100
Message-ID: <56BC5C8C.8060201@alum.mit.edu>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
 <1454701462-3817-13-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 11:11:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aToDb-0007X0-Gh
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 11:11:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbcBKKLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 05:11:18 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:58841 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750725AbcBKKLO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Feb 2016 05:11:14 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Feb 2016 05:11:14 EST
X-AuditID: 12074414-8b3ff70000005020-8e-56bc5c8ef848
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 4F.71.20512.E8C5CB65; Thu, 11 Feb 2016 05:03:58 -0500 (EST)
Received: from [192.168.69.130] (p548D69E5.dip0.t-ipconnect.de [84.141.105.229])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1BA3uMZ003456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 11 Feb 2016 05:03:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
In-Reply-To: <1454701462-3817-13-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsUixO6iqNsXsyfMoP2zqcX8TScYLbqudDM5
	MHkseH6f3ePzJrkApihum6TEkrLgzPQ8fbsE7owTT56zFhxnrfjw/TN7A+MWli5GTg4JAROJ
	w4u2MXcxcnEICWxllLi4bgUThHOBSeLCtPvsIFXCAlYSM97tBrNFBBwkLu86CtXRxihx+vVp
	JpAEm4CuxKKeZjCbV0Bb4tCHDrAGFgFViWUftzOC2KICIRLvvz5nhagRlDg58wnYGZwCnhIb
	lj4Cs5kF9CR2XP/FCmHLS2x/O4d5AiPfLCQts5CUzUJStoCReRWjXGJOaa5ubmJmTnFqsm5x
	cmJeXmqRroVebmaJXmpK6SZGSPCJ7GA8clLuEKMAB6MSD++Pmt1hQqyJZcWVuYcYJTmYlER5
	D7rtCRPiS8pPqcxILM6ILyrNSS0+xCjBwawkwvsgGijHm5JYWZValA+TkuZgURLn/bZY3U9I
	ID2xJDU7NbUgtQgmK8PBoSTB2wPSKFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+K
	vvhiYPyBpHiA9i4D21tckJgLFIVoPcWoy7Hgx+21TEIsefl5qVLivFtBigRAijJK8+BWwFLN
	K0ZxoI+FecWBiUeIB5im4Ca9AlrCBLRkx/ddIEtKEhFSUg2MKSsTTl68cW2n1Pz6l8oTs7rj
	lhRoWLC7q6uzLFTh/pIp15ko0X25X+/HZfnVFsLPb6i+TTgd8Plurqvpim3dy/oVFl/hkXr9
	0yDGgrch590/K9MjAlXfzJs5760Vfb1sw8/Pi3kPM3MvDGa82n1dS/634bT8c8Yf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285956>

On 02/05/2016 08:44 PM, David Turner wrote:
> The refs infrastructure learns about log-only ref updates, which only
> update the reflog.  Later, we will use this to separate symbolic
> reference resolution from ref updating.

This looks good. I assume it will get some testing later in the series.

> [...]
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index fc5d1db..b5d0ab8 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -42,6 +42,8 @@
>   * value to ref_update::flags
>   */
>  
> +#define REF_LOG_ONLY 0x80
> +

Please add a comment explaining the meaning/purpose of this flag.

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
