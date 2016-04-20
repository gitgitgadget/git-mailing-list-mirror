From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 03/15] index-helper: new daemon for caching index and
 related stuff
Date: Wed, 20 Apr 2016 14:19:16 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604201418550.2826@virtualbox>
References: <CACsJy8D_4KFjz6HefvzmWw-6Qqg0uguq8MXL6kLY0oMyVhPS0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 14:19:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asr6O-00055b-AH
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 14:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbcDTMTY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 08:19:24 -0400
Received: from mout.gmx.net ([212.227.15.18]:57820 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932154AbcDTMTX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 08:19:23 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LnxQO-1bPyvt2RkO-00fwna; Wed, 20 Apr 2016 14:19:17
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CACsJy8D_4KFjz6HefvzmWw-6Qqg0uguq8MXL6kLY0oMyVhPS0w@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:GUIHjL8BZZBMwGsnvLtIsgPkcuAkM0Oob57DrlxE2IysCStMLg9
 FqgMkpJ7U2WvuOkbYJRwgVfd4/DkyknbuuIum98n0uLsqAHOIzgb+6smTlH48xVIhJxuUoO
 G4ndnV1yrzi/Ko1Nv/fFtfmP3vsfqQ0YaPm+pKNQjg5rQMNsw2UqG/ZeeeOS+hEilqVhwgd
 bYYd+B69JXgyIwSM9GlSw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:U9BVDPdHStM=:ojFHq3/G2N4dTWzEXbF1O+
 fitKVRqtdcfmnJYN2HphIL05BCOZgdnRHAZzSyQCuXtgoXVJMVKprykTEqrUWFJafidKSbP2j
 3YMCQqmETkE1P8Hm/JJfy2U6I+/dJMrvGVb1x+6WYmJWj48oMPXzHttleelIdMhJKPXkAW5Yo
 dOwqxq/SnlzmRHC5+r59EIWh5oLuyBy8c/MBqt3In7BZbxTsgV1dj440E4bvPKduzaGPcDxFX
 sk00cJWcU3pfZX6y/0nu/OWniak9JrCJYE1ZSH6inBOmvodQdQ0Iv3Tvbo3pWCSAOQHkspOVM
 sls/xMs2A8BiZUic7hiVPAxqXKOSnxHSnkdr9JxpUUEiixz4CrDpbCznpnFADJZGxqgeDSLxQ
 L7VmtT0Yn/z7w7SfxDQ9zH1nNnj/ALcJh7o6Bk6KGbZA97BpWcFhekOBYTSPuxuOISNUZYQuR
 paSRKRUYjK6hJH2kQfXbQZTnz2iBlarpMVggL7FzTLS8Jxt9rGqupmSM7Y7ipB5NIgCnZNJ07
 iQyksX9wsHt7g3x+Q6CpI5IukfezuqoKA7ouPkUqP+v0NvVsClYaEH7OAJXs6DtpKUoDZ7xag
 W1gpjvKfrl9eTdJx+GRYvggUPifV2LVsP854wS3XSAZRKOTd6GljuZ5tNhb/Ec2T0XcvIjqe8
 H4Mo63GxgTF2qCMzhN32zzMre1SzRLHhbQSX24AHH8+3gBdovACMgHIgdniQS4XeC6XQ4yLwJ
 SanXS6bwPCI1CzqwM4LnZFGlD50mKqC76ZxVtRs+K8b//ecRxubN4B4yCx5D/I9wHJ/SENmy 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292005>

Hi Duy,

On Wed, 20 Apr 2016, Duy Nguyen wrote:

> On Wed, Apr 20, 2016 at 6:27 AM, David Turner <dturner@twopensource.com> wrote:
> > Shared memory is done by storing files in a per-repository temporary
> > directory.  This is more portable than shm (which requires
> > posix-realtime and has various quirks on OS X).  It might even work on
> > Windows, although this has not been tested.
> 
> There's another option, but I'm not sure if it's too clever/tricky to
> do. Anyway, on *nix we can send file descriptors over unix socket [2],
> then mmap them back to access content.

This sounds too clever to me ;-)

Ciao,
Dscho
