From: "Dana How" <danahow@gmail.com>
Subject: Re: [RFD/PATCH] Implement pack.compression and pack-objects --compression=N
Date: Fri, 4 May 2007 12:51:15 -0700
Message-ID: <56b7f5510705041251v1a09103eif677c02efc53059e@mail.gmail.com>
References: <463802ED.1080200@gmail.com>
	 <7vk5vr3w8n.fsf@assigned-by-dhcp.cox.net>
	 <56b7f5510705021155k40b576d6ke286e65494fc8b05@mail.gmail.com>
	 <56b7f5510705021551q2d48f1e5i3f4a5c2f9891368a@mail.gmail.com>
	 <7vejlxxho1.fsf@assigned-by-dhcp.cox.net>
	 <alpine.LFD.0.99.0705040937250.24220@xanadu.home>
	 <56b7f5510705040910i3cac723co3aed45034c097def@mail.gmail.com>
	 <alpine.LFD.0.99.0705041218130.24220@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri May 04 21:51:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk3oI-00079Z-9q
	for gcvg-git@gmane.org; Fri, 04 May 2007 21:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161919AbXEDTvS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 15:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161922AbXEDTvS
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 15:51:18 -0400
Received: from nz-out-0506.google.com ([64.233.162.230]:33878 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161919AbXEDTvR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 15:51:17 -0400
Received: by nz-out-0506.google.com with SMTP id o1so973437nzf
        for <git@vger.kernel.org>; Fri, 04 May 2007 12:51:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lqilINzthF72Ru+7YwfuwR6EB/go/DY/SVxTgLTD39lOk1+yTOxlJC2UD3stIqaV45mWh+fFFn7l7D2hcvshl+Gl+bUkgyNs2gUz5m4BlTcwh+qrfrjL2ljSncUpkhV8YCRilKNvrVn03+yMiU5zs6e0CPV5Bk7+69tKwy4DcS4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PfRIceIB6R5Vu8181P3+MIDX3tDO06W1eAJAPBIsYyENcI0xwYxx60IMgBbnNAlHiJ1O/kkvRP6Pmwrg9XdTP1nGaqusQOwGrjDceVF+JYPPLfLMF1BS1jZ3vxuyl639bD1opOyaNHN6ttq8454al3cgbI1eXvQp7rc2updMo6c=
Received: by 10.114.170.1 with SMTP id s1mr1242566wae.1178308275452;
        Fri, 04 May 2007 12:51:15 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Fri, 4 May 2007 12:51:15 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.99.0705041218130.24220@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46208>

On 5/4/07, Nicolas Pitre <nico@cam.org> wrote:
> On Fri, 4 May 2007, Dana How wrote:
> > On 5/4/07, Nicolas Pitre <nico@cam.org> wrote:
> > > I think that would make sense to have separate configs for pack and
> > > loose object compression.  When not specified they should simply default
> > > to core.compression if it exists.  Otherwise I'd suggest that pack
> > > compression default level be Z_DEFAULT_COMPRESSION and loose object
> > > compression default level be Z_BEST_SPEED.  This would make interactive
> > > operations like git-add and git-commit even faster by default.
> > I agree with your Z_BEST_SPEED idea.  I did not include it in
> > the patch b/c I didn't want to change any behavior in the absence
> > of new config settings.
> > Are you actually arguing for *3* different compression-related config
> > variables?
> Yes.
>
> > How about:
> > (a) core.compression controls loose objects. defaults to Z_BEST_SPEED.
> > (b) pack.compression controls packing. defaults to Z_DEFAULT_COMPRESSION
> > if neither variable exists. defaults to core.compression if only that exists
> Yes, although I wouldn't default pack.compression to core.compression
> if pack.compression doesn't exist.  The documentation about
> core.compression currently talks
> (wrongly) only about loose objects anyway, so making pack.compression
> stand on its own won't be that bad.

Now that I'm awake your original quote at the top suggests:
(a) zlib_compression_level =
     isset(core.loosecompression) ? core.loosecompression :
     isset(core.compression) ? core.compression : Z_BEST_SPEED;
(b) pack_compression_level =
     isset(pack.compression) ? pack.compression :
     isset(core.compression) ? core.compression : Z_DEFAULT_COMPRESSION;

Your later reaction to my quoted (a)/(b) table suggests:
(a) zlib_compression_level =
     isset(core.compression) ? core.compression : Z_BEST_SPEED;
(b) pack_compresion_level =
     isset(pack.compression) ? pack.compression : Z_DEFAULT_COMPRESSION;

In either case,  the C variable
zlib_compression_level controls compression level for loose objects,
and pack_compression_level controls compression in a pack.
"isset()" means an active setting does appear in a config file
(it could be the default value).

The 2nd behavior table is sufficient for me and simpler than my patch.
Do you want the 1st or 2nd behavior?

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
