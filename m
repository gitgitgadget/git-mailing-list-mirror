From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate $GITDIR
Date: Thu, 18 Apr 2013 09:01:29 +1000
Message-ID: <CACsJy8AZK4iG4FsM=2wVTggyABBQUeeqb5_3qkWfuAqp0QhKUA@mail.gmail.com>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com>
 <CACsJy8D-5x5HXgpr2hHUHee6jcfj3++b961sJB_aKTZC1ZS+tw@mail.gmail.com>
 <CALkWK0kw69rMveDXpGEvV=fGxiQ7JoT_JE9ZU5cor0xD=BUbFQ@mail.gmail.com>
 <CACsJy8C9mrJzmg4FjqBMAZis7WQUpyhNH7TMTLbebWQE124YMg@mail.gmail.com>
 <CALkWK0nLamX1XKcg2t7VWJTPuFhX+ctEGE=4sjSSd7JqMmGzPA@mail.gmail.com>
 <CACsJy8DxspNbopJbSsvcCZZwMFees1JVV_iV5r7dXRJTngzmFA@mail.gmail.com> <CALkWK0kchO-cKuh1vd=aziZa5CA8w81aEecUKqhazp_Y7pOrkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 01:02:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USbMb-0000BL-GN
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 01:02:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966972Ab3DQXCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 19:02:00 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:60448 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966920Ab3DQXB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 19:01:59 -0400
Received: by mail-ob0-f175.google.com with SMTP id va7so1931554obc.20
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 16:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Bgr2LvooBZ85m2VpvsNOh/LwaByIQItdkKn9OFw5N/w=;
        b=oxIHMjuxRjpK8n1s1nrGizIdKZqhj2pXRonxUkkBOTAk/bGDmJhUyvw9068dSkvOtg
         Yb4gqceKXbIW7w50OUBJrqriH3bYAatI/3Z3M4D+rdaUS01yI82W6Ka3NTFKI4daVxVa
         vrxk1K9ScXrM2qV5QP+GXD+klSdZqpGqM4mLC+z01dvW+IlA/Y5Ukf27naLgeqD/reNW
         VryivsYMxXlcxLhA8pQCj450kOaKlVY6QY24Cn0vJ5OHft8JiKxNMEYRJ5Dl4UAmCokb
         2L918p2gpYOMpcrBLdVDOZWzDY/ousbOxsHI934EBAXySuM2C1POq1jIZqcni5rT3VXN
         Y2BQ==
X-Received: by 10.60.142.230 with SMTP id rz6mr3926346oeb.22.1366239719446;
 Wed, 17 Apr 2013 16:01:59 -0700 (PDT)
Received: by 10.76.122.163 with HTTP; Wed, 17 Apr 2013 16:01:29 -0700 (PDT)
In-Reply-To: <CALkWK0kchO-cKuh1vd=aziZa5CA8w81aEecUKqhazp_Y7pOrkw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221582>

On Thu, Apr 18, 2013 at 1:02 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
>> No, the point is people make mistakes. What do we do in that case? Or
>> will you introduce yet another "gc" command for clean up ~/bare?
>
> So, people don't make mistakes when they use 'git submodule add', but
> do make mistakes when using 'git clone'?  How has the problem
> _changed_ with my patch?  It's reasonable to point it out as an
> existing problem, and ask for it to be fixed independent of this
> discussion, but that is not what you are doing.

It's the magic in git-clone that changes its behavior that I want to
address. I know you agree to go with a command line option. But I
think in the end there will be a switch hidden somewhere in config to
make things smooth, unless you make this mode the default (*). With
normal mode, "rm -rf repo" is enough, with the new submodule mode, it
leaves some garbage behind that the user may not be aware about. Maybe
this is something that should be addressed anyway even for .gitmodules
mode like Junio said. But I wonder if there are any other traps that
come with the config switch.

(*) I don't think you can make the new mode the default though. There
are repos in repos in the field that are not managed by "git
submodule". Switching the default will disrupt those setups. Some
deprecation cycles might help, I don't know.
--
Duy
