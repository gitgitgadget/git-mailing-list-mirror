From: Shawn Pearce <spearce@spearce.org>
Subject: Re: GSoC resumable clone
Date: Fri, 11 Mar 2011 07:41:14 -0800
Message-ID: <AANLkTi=D5kYh-w-6CKuCf39fnH1SYT5HxJ31tdq2vb9d@mail.gmail.com>
References: <AANLkTinrgqLhZK=fQ_+gUanT-zy9Mcbw-y3o7nYV9A-m@mail.gmail.com> <20110311153752.GA30329@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Alexander Miseler <alexander@miseler.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>,
	Pranav Ravichandran <prp.1111@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 11 16:41:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Py4TF-0002BC-IJ
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 16:41:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755545Ab1CKPlg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 10:41:36 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:55813 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754736Ab1CKPlf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 10:41:35 -0500
Received: by vxi39 with SMTP id 39so2640038vxi.19
        for <git@vger.kernel.org>; Fri, 11 Mar 2011 07:41:35 -0800 (PST)
Received: by 10.52.172.205 with SMTP id be13mr13853561vdc.76.1299858095150;
 Fri, 11 Mar 2011 07:41:35 -0800 (PST)
Received: by 10.52.162.33 with HTTP; Fri, 11 Mar 2011 07:41:14 -0800 (PST)
In-Reply-To: <20110311153752.GA30329@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168909>

On Fri, Mar 11, 2011 at 07:37, Jeff King <peff@peff.net> wrote:
> On Fri, Mar 11, 2011 at 07:17:31AM -0800, Shawn O. Pearce wrote:
>
>> >> A simpler way to restartable clone is to facilitate bundles (Nicolas'
>> >> idea). Some glue is needed to teach git-fetch/git-daemon to use the
>> >> bundles, and git-push to automatically create bundles periodically (or
>> >> a new command that can be run from cron). I think this way fit in GSoC
>> >> scope better.
>>
>> I think the cached bundle idea is horrifically stupid in the face of
>> the subsequent cached pack idea. JGit already implements cached packs,
>> and it works very well. The feature just needs to be back-ported to
>> builtin/pack-objects.c, along with some minor edits to my RFC patch to
>> git-repack.sh to be able to construct the cached pack.
>
> I think there is room for both ideas. The cached bundle idea is not just
> "here, download this bundle first". It is "here, download this _other
> thing_ first, which might be a bundle, another git repo, a torrent,
> etc".

Fair enough. Though I wouldn't limit this to bundles. Instead I would
suggest supporting any valid Git URLs, and then extend our URL syntax
to support bundles over http://, rsync://, and torrent.

> So yeah, cached packs are a way better solution if you are just going to
> have an extra bundle on the same machine. But that's just one use case.
> The ability for my server to say "go hit kernel.org first, and then come
> back to me to pick up the deltas" is also valuable. Similarly, the
> ability to serve an initial bundle off a torrent is useful for extremely
> large projects.

If we support any URL and don't assume the URL is a bundle, you can
point traffic at kernel.org to for example grab Linus' primary
repository first, even if he doesn't have a bundle.

-- 
Shawn.
