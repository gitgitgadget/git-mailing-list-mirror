From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/4] reachable.c: mark reachable objects in index from all worktrees
Date: Thu, 2 Jun 2016 16:35:18 +0700
Message-ID: <CACsJy8BCrCYDpAXUrkFvFNXrua39Ou1r5=s_NK28Pm61O+u-rQ@mail.gmail.com>
References: <574D382A.8030809@kdbg.org> <20160601104519.16563-1-pclouds@gmail.com>
 <20160601104519.16563-3-pclouds@gmail.com> <CAPig+cRzRa1uZ+2jD4_uCSisb+0dywPGV3AVE38-xZr3hauTtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	David Turner <dturner@twopensource.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 11:36:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8P2k-0006ak-Dj
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 11:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbcFBJfu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jun 2016 05:35:50 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:33970 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932440AbcFBJfs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2016 05:35:48 -0400
Received: by mail-io0-f194.google.com with SMTP id l9so5807593ioe.1
        for <git@vger.kernel.org>; Thu, 02 Jun 2016 02:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5hyOiZ7ooy4K8jLSwo8Xl3W3y8x3oO+tGVwA57wGXM4=;
        b=RuVkX8EV1PYQI/VQqGS4JiDRBteollJULzRI8fFO8wL+N0Mc+3PN0rlXHPH8r/HYyt
         uVMqN7Jy+Mvx0pg/b6ibRU5u2fGPYJkG+qJJJdB3QZswF2sZFx4Hn6AzOj0/C+MVdfqb
         t5qQNpfvXYX7Qwlku8Pi6UeE3UzHHGBuDa9go9X7PhURl035qN5A7uKh1ily1aej59wS
         O02QcXZDgrc8/78iolyQEDxZad8ctmF2PL9GNVO3Q5sjVo0VmzGLvosjtbdxDsucopPZ
         zJ4hCaVyv1C1jzs6091h4+lIIafCLkmTwAQd+Wp2+N/dqSGR0U8ZmxejiO9ErjhxLTt0
         s0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5hyOiZ7ooy4K8jLSwo8Xl3W3y8x3oO+tGVwA57wGXM4=;
        b=c+YbeLJ+GZYrrmpRQom24ZPfijwpqI3VxCGo7fS8f65dwt5OYQFXjcfcn6gumZMU4j
         dnVPu4Ilc3pZ61K7H5jZ/JrbuXsRnsRos0NXz//xhFyR/zBbisTQJFT35563jPVsQ3fq
         A5V4u9s1ACuf04tgVWB7sQ+Mze/mB8miPvX/Qxoh6eDX1YVI/qPVooj+oWA7lhTosSTS
         vLePg+6s2LLYomaUvXGvkEVsg5UCJI+eBTXOAEYshyXP00dAotEAUuoO6nYqv83TXo3H
         z93YwvppgAkAogoM/hCPh+UJHsw1O4K5eIpyPPVb6WuQf96OzKan1ScKNK22kQud1Jq5
         LyXg==
X-Gm-Message-State: ALyK8tKnCFYI5wrrvvmxy5igys+R41oSEoOkNYwccGj/YQe9eVWp6oCYXKmqt16RP2/Ykpb+K0HeLA1LXwmeJQ==
X-Received: by 10.107.22.131 with SMTP id 125mr1998624iow.128.1464860147924;
 Thu, 02 Jun 2016 02:35:47 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Thu, 2 Jun 2016 02:35:18 -0700 (PDT)
In-Reply-To: <CAPig+cRzRa1uZ+2jD4_uCSisb+0dywPGV3AVE38-xZr3hauTtA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296189>

On Thu, Jun 2, 2016 at 1:13 AM, Eric Sunshine <sunshine@sunshineco.com>=
 wrote:
> On Wed, Jun 1, 2016 at 6:45 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy <pclouds@gmail.com> wrote:
>> Current mark_reachable_objects() only marks objects from index from
>> _current_ worktree as reachable instead of all worktrees. Because th=
is
>> function is used for pruning, there is a chance that objects referen=
ced
>> by other worktrees may be deleted. Fix that.
>>
>> Small behavior change in "one worktree" case, the index is read agai=
n
>> from file. In the current implementation, if the_index is already
>> loaded, the index file will not be read from file again. This adds s=
ome
>> more cost to this operation, hopefully insignificant because
>> reachability test is usually very expensive already.
>
> Could this extra index read be avoided by taking advantage of 'struct
> worktree::is_current'[1] and passing the already-loaded index to
> add_index_objects_to_pending() if true?
>
> Or, am I misunderstanding the issue?
>
> [1]: http://article.gmane.org/gmane.comp.version-control.git/292194

Hah! I broke my worktree changes into many pieces and lost track of
them. I thought that one was still in some unsent series. Will use it.
--=20
Duy
