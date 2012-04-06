From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [GSoC] Designing a faster index format
Date: Fri, 6 Apr 2012 17:24:26 +0200
Message-ID: <878vi8sx1x.fsf@thomas.inf.ethz.ch>
References: <F9D452C3-B11E-4915-A0F2-B248F92CE5DE@gmail.com>
	<8D287169-1AD9-4586-BDBC-F820220328FC@gmail.com>
	<CACsJy8D2RwG-Nr5btcQj0f9=JACvH6mf7LNi=Jnb_y+j4_2u0A@mail.gmail.com>
	<871uomrubl.fsf@thomas.inf.ethz.ch>
	<8901F6B5-7396-44E1-9687-20BF95114728@gmail.com>
	<871uomq64c.fsf@thomas.inf.ethz.ch>
	<BDFA27C9-C999-4C95-8804-5E7B3B3D1BFD@gmail.com>
	<878virfx11.fsf@thomas.inf.ethz.ch>
	<2A61C352-5C71-4EDF-9DBE-01CC09AE03A5@gmail.com>
	<87r4we9sfo.fsf@thomas.inf.ethz.ch>
	<5CE5AEC7-22C8-4911-A79E-11F2F3D902A2@gmail.com>
	<7vk423qfps.fsf@alter.siamese.dyndns.org>
	<CACsJy8Ag9yvGwKE_oiW8T+hR2hN_fzXvGCdOJ_H44DCOm9RF0Q@mail.gmail.com>
	<1604FE70-8B77-4EC1-823A-DC1F0334CD3A@gmail.com>
	<4F7ABA19.7040408@alum.mit.edu>
	<C15BAB9A-EAFA-4EA4-85B2-0E0C5FF473E9@gmail.com>
	<alpine.DEB.2.02.1204031313170.10782@asgard.lang.hm>
	<D97085E6-2B9F-42C5-A06D-B53422034071@gmail.com>
	<87r4w1vofu.fsf@thomas.inf.ethz.ch>
	<CAJo=hJssfTvGqzQtaAj+Dk_R2oU5BwY=sQQuH3=SFTf+Zcp=3A@mail.gmail.com>
	<CACsJy8DaBxCtU7UQcc510J71zk95DMMsWdr9S3eYTupdRLjWBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shawn Pearce <spearce@spearce.org>,
	Thomas Gummerer <italyhockeyfeed@gmail.com>, <david@lang.hm>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 17:24:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGB1f-00015a-BI
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 17:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757358Ab2DFPYa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Apr 2012 11:24:30 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:55714 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754317Ab2DFPY3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Apr 2012 11:24:29 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.283.3; Fri, 6 Apr
 2012 17:24:24 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 6 Apr
 2012 17:24:27 +0200
In-Reply-To: <CACsJy8DaBxCtU7UQcc510J71zk95DMMsWdr9S3eYTupdRLjWBg@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Fri, 6 Apr 2012 22:11:49 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194874>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Fri, Apr 6, 2012 at 10:22 AM, Shawn Pearce <spearce@spearce.org> w=
rote:
>> On Thu, Apr 5, 2012 at 14:49, Thomas Rast <trast@inf.ethz.ch> wrote:
>>> This is quite complete already, which I think is great, but it's st=
ill
>>> missing one "obvious" approach: a directory-tree based layout that =
uses
>>> "flat" storage. =C2=A0That is, the entries grouped by directory and=
 thus
>>> arranged into the "natural" tree, so as to allow parsing only part =
of
>>> it. =C2=A0But not pulling any tricks to make it easy to change; a n=
ontrivial
>>> change would mean a rewrite. =C2=A0How good do you think that could=
 be?
>>
>> I have been wondering this myself. Aren't most updates to the index
>> just updating the stat information of an existing entry?
>>
>> If so we could structure the index as flat lists for each directory
>> similar to a canonical tree, but with a wider field to hold not just
>> the SHA-1 but also the stat information of each file. If the entry i=
s
>> just the component name ("foo.c" and not "src/foo.c") and the SHA-1
>> and stat data, you can probably protect the entire entry with a CRC-=
32
>> for each entry. Updates can be performed in place by taking the writ=
e
>> lock with index.lock as an empty file, then overwriting the SHA-1 an=
d
>> stat field followed, by updating the CRC-32. Readers that see the
>> wrong CRC-32 for an entry can sleep for a short period, retry the
>> read, and fail after some number of attempts if they cannot get a
>> valid read of that entry.
>
> But does that mean the reader can have some old entries (because the
> writer has not updated them yet by the time of reading) mixed with ne=
w
> ones, i.e. inconsistent data?

That can be fixed with another CRC or hash covering the CRCs for the
entries, so that a reader can notice a partial update.

But even so: do we make any promises that (say) git-add is atomic in th=
e
sense that a reader always gets the before-update results or the
after-update results?  Non-builtins (e.g. git add -p) may make small
incremental updates to the index, so they wouldn't be atomic anyway.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
