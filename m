From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: How to check repository/working tree status from a script
Date: Wed, 20 May 2009 13:19:05 +0200
Message-ID: <adf1fd3d0905200419s33d5c73ahba240b354aca87a3@mail.gmail.com>
References: <20090519143537.GA23505@torres.zugschlus.de>
	 <alpine.LSU.2.00.0905191630120.23478@hermes-2.csi.cam.ac.uk>
	 <20090519160031.GB23505@torres.zugschlus.de>
	 <alpine.LFD.2.01.0905190915050.3301@localhost.localdomain>
	 <20090520111028.GA15453@torres.zugschlus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marc Haber <mh+git@zugschlus.de>
X-From: git-owner@vger.kernel.org Wed May 20 13:20:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6jqm-000298-Ok
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 13:20:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756504AbZETLTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 07:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756017AbZETLTf
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 07:19:35 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:43463 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756140AbZETLTF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 07:19:05 -0400
Received: by fxm2 with SMTP id 2so346631fxm.37
        for <git@vger.kernel.org>; Wed, 20 May 2009 04:19:05 -0700 (PDT)
Received: by 10.204.62.135 with SMTP id x7mr1119920bkh.124.1242818345622; Wed, 
	20 May 2009 04:19:05 -0700 (PDT)
In-Reply-To: <20090520111028.GA15453@torres.zugschlus.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119602>

2009/5/20 Marc Haber <mh+git@zugschlus.de>:
> On Tue, May 19, 2009 at 09:18:12AM -0700, Linus Torvalds wrote:
>> On Tue, 19 May 2009, Marc Haber wrote:
>> > On Tue, May 19, 2009 at 04:34:47PM +0100, Tony Finch wrote:
>> > > On Tue, 19 May 2009, Marc Haber wrote:
>> > > > I would like to check in a script whether there (a) are uncommitted
>> > > > changes (as in "working tree differs from local repository")
>> > >
>> > > # check working tree is not different from the index
>> > > git diff --quiet
>> > > # check that the index is not different from the head
>> > > git diff --quiet --cached
>> >
>> > $ git diff --quiet; echo $?
>> > 0
>> > $ git diff --quiet --cached; echo $?
>> > 0
>> > $ touch keks
>> > $ git diff --quiet; echo $?
>> > 0
>> > $ git diff --quiet --cached; echo $?
>> > 0
>> > $
>> >
>> > Am I missing something?
>>
>> If "keks" is already something you know about, then 'touch' wouldn't have
>> changed it, so diff won't show it.
>
> keks didn't exist previously, so the touch generated a new empty 0 byte
> file.

And 'git diff' alone only cares about files it knows.

>
>> And if what you want to know about is whether there are _new_ files you
>> might want to check, then you need a third check: 'git ls-files'. You
>> won't see it in the error code, but you can do
>>
>>       others=$(git ls-files -o --exclude-standard)
>>
>> and then check it 'others' is empty or not.
>
> So parsing the output is both the canonical and only way to do so
> since there is no meaningful exit code? Can I assume that the
> formatting of git output is not subject to change?

Git output for the plumbing comands do not change, it is designed for
script use. OTOH git output for porcelain commands can change. 'git
ls-files' is a plumbing commands, see git's manpage for the complete
list.

HTH,
Santi
