From: Shawn Pearce <spearce@spearce.org>
Subject: Re: large files and low memory
Date: Mon, 4 Oct 2010 11:57:34 -0700
Message-ID: <AANLkTi=nzyRgiBL07f2oeyjdUc8XnaKbJEJ+k8_g9rQ1@mail.gmail.com>
References: <20101004092046.GA4382@nibiru.local> <AANLkTimbdrAqoWMxiteT5zNYmwHp8M698BEv1FLuiAxx@mail.gmail.com>
 <4CAA1BEB.3050908@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: weigelt@metux.de, git@vger.kernel.org
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 20:58:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2qEs-0007nu-A2
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 20:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308Ab0JDS54 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 14:57:56 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46655 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932243Ab0JDS5z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 14:57:55 -0400
Received: by iwn5 with SMTP id 5so7249264iwn.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 11:57:54 -0700 (PDT)
Received: by 10.231.19.3 with SMTP id y3mr10631095iba.156.1286218674563; Mon,
 04 Oct 2010 11:57:54 -0700 (PDT)
Received: by 10.231.168.70 with HTTP; Mon, 4 Oct 2010 11:57:34 -0700 (PDT)
In-Reply-To: <4CAA1BEB.3050908@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158093>

On Mon, Oct 4, 2010 at 11:24 AM, Joshua Jensen
<jjensen@workspacewhiz.com> wrote:
>> On Mon, Oct 4, 2010 at 2:20 AM, Enrico Weigelt<weigelt@metux.de> =A0=
wrote:
>>>
>>> when adding files which are larger than available physical memory,
>>> git performs very slow.
>>
>> The mmap() isn't the problem. =A0Its the allocation of a buffer that=
 is
>> larger than the file in order to hold the result of deflating the fi=
le
>> before it gets written to disk.
=2E..
>> This is a known area in Git where big files aren't handled well.
>
> As a curiosity, I've always done streaming decompression with zlib us=
ing
> minimal buffer sizes (64k, perhaps). =A0I'm sure there is good reason=
 why Git
> doesn't do this (delta application?). =A0Do you know what it is?

Laziness.  Git originally assumed it would only be used for smaller
source files written by humans.  Its easier to write the code as a
single malloc'd buffer than to stream it.  We'd like to fix it, but
its harder than it sounds.  Today we copy the file into a buffer
before we deflate and compute the SHA-1 as this prevents us from
getting into a consistency error when the file is modified between
these two stages.

--=20
Shawn.
