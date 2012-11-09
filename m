From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: git-clone and unreliable links?
Date: Fri, 9 Nov 2012 22:05:54 +0530
Message-ID: <CAMK1S_jK2w2RYWbFmqnwJdSVmFnacGPLbEGzUWOLukqK_=HEbA@mail.gmail.com>
References: <20121107153519.GI28437@raven.wolf.lan>
	<CAJo=hJtJPnQFjvz8AAQjf5Rze-_99vF_tYi9CqJ7fiW245Dv1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Josef Wolf <jw@raven.inka.de>, git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Nov 09 17:36:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWrYz-00036b-HI
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 17:36:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754566Ab2KIQgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 11:36:00 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35901 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754553Ab2KIQf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 11:35:56 -0500
Received: by mail-lb0-f174.google.com with SMTP id n3so3170279lbo.19
        for <git@vger.kernel.org>; Fri, 09 Nov 2012 08:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wBCzn/Tp60izF1JnRLes40idnBoS8R4Myf1bFjOIY5A=;
        b=Hqg4lTfaMfSpFnyceyWWDp1B1YpQBOmIsBKBWMcXcGIrth+sZmp0Lt2yDO/J5HpTKX
         6KcBRcun98zJwLMFaOl10gpSHXF+KGUTGK+JZSaiz3oqigbfa62mkhGDTA1CJlhmuCyn
         r/bQgpDULCSRIZp7VDw5lsmLI8s4duwsmMGYpx+ZzomoN3Km/2KsX5gVcmlwZZWa7VLw
         NjW+12llQtWf0NN2CcPpcxh+W2E3j+V98okh/K9GRBJyMjpOJnycjk/rEda4Bfc9TpKm
         Jozx+XMQygyRPEudoH2pD+Yx3IDS0vAgjNDw/AUzUqSSDsoyu9nwaBpH7iijOp7K7ZDC
         fFNQ==
Received: by 10.112.82.103 with SMTP id h7mr4790092lby.50.1352478954818; Fri,
 09 Nov 2012 08:35:54 -0800 (PST)
Received: by 10.112.113.103 with HTTP; Fri, 9 Nov 2012 08:35:54 -0800 (PST)
In-Reply-To: <CAJo=hJtJPnQFjvz8AAQjf5Rze-_99vF_tYi9CqJ7fiW245Dv1w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209229>

On Wed, Nov 7, 2012 at 9:24 PM, Shawn Pearce <spearce@spearce.org> wrote:
> On Wed, Nov 7, 2012 at 7:35 AM, Josef Wolf <jw@raven.inka.de> wrote:
>> When using git-clone over an unreliable link (say, UMTS) and the network goes
>> down, git-clone deletes everything what was downloaded. When the network goes
>> up again and you restart git-clone, it has to start over from the
>> beginning. Then, eventually, the network goes down again, and everything is
>> deleted again.
>>
>> Is there a way to omit the deleting step, so the second invocation would start
>> where the first invocation was interrupted?
>
> No, because a clone is not resumable.
>
> The best way to obtain a repository over an unstable link is to ask
> the repository owner to make a bundle file with `git bundle create
> --heads --tags` and serve the file using standard HTTP or rsync, which
> are resumable protocols. After you download the file, you can clone or
> fetch from the bundle to initialize your local repository, and then
> run git fetch to incrementally update to anything that is more recent
> than the bundle's creation.

If the server is running gitolite, the admin can set it up so that a
bundle file is automatically created as needed (including "don't do it
more than once per <duration>" logic), and serve it up over rsync
using the same ssh credentials as for access to the repo itself.

However, this is not particularly useful for systems with git://,
although it could certainly be *adapted* for http access.

[Documentation is inline, in src/commands/rsync, for people who wish to know.]

-- 
Sitaram
