From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [1.8.0] reorganize the mess that the source tree has become
Date: Tue, 1 Feb 2011 01:35:16 +0100
Message-ID: <AANLkTim6YN5k+JjxYBkfpXYze1MRxFNAmSeJ_0CQpBnf@mail.gmail.com>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1101311459000.8580@xanadu.home> <20110131210045.GB14419@sigill.intra.peff.net>
 <alpine.LFD.2.00.1101311621150.8580@xanadu.home> <20110131231210.GD14419@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 01 01:35:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk4Dm-0007js-JW
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 01:35:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756548Ab1BAAfk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Jan 2011 19:35:40 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61070 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756531Ab1BAAfi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jan 2011 19:35:38 -0500
Received: by fxm20 with SMTP id 20so6244164fxm.19
        for <git@vger.kernel.org>; Mon, 31 Jan 2011 16:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=11q08dtuh4MKJ0pw/jNfL4qHd7xvsUWhdEgtsbUVEMI=;
        b=AHhP6ZzFmfJ3O4NNasijCwF6yeMam3LeGyk/DwjXBEJlCp82/UQL8cU94qQ61ILidW
         koXIRYeNOodFgRGYXETfRD3cRAfjIbvvYn/zh/4eOA3Mf8o93KsXqxa+p3oGkXiIbxFr
         FE5LoRF5Z2OWw3g4xiOfsydNf5dj088obBeG4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=ZUSoVC3KKoqWC0viI+uyIyBtEYj2bBods57/5yVTqNoifP3RPhuZhn0kAs2zOLVNDA
         YTeDiM8Lkc3v1lanbUSHS45b5h/IsHSKml9ZGps3vn1eW0kDWtu+tVwPqLOZaf341GP/
         wvPTA507b6GCw3/Cs7Y2Spe1sT1HMv2bx6BKE=
Received: by 10.223.83.208 with SMTP id g16mr6766829fal.52.1296520536547; Mon,
 31 Jan 2011 16:35:36 -0800 (PST)
Received: by 10.223.116.210 with HTTP; Mon, 31 Jan 2011 16:35:16 -0800 (PST)
In-Reply-To: <20110131231210.GD14419@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165782>

On Tue, Feb 1, 2011 at 12:12 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Jan 31, 2011 at 04:28:49PM -0500, Nicolas Pitre wrote:
>
>> > Besides being just one more directory to go up and down, it does m=
ake
>> > history browsing more annoying. As much as I love git's "don't rec=
ord
>> > renames" philosophy, our handling of renames on the viewing side i=
s
>> > often annoying. I already get annoyed sometimes following stuff ac=
ross
>> > the s!builtin-!builtin/! change. This would be like that but more =
so.
>>
>> So... we do suck at something? =A0So why not take this opportunity t=
o
>> shake yourself out of this easy comfort and improve Git as a result =
on
>> both front? =A0:-)
>
> Yes, we do suck at rename following. The problem is that it is partia=
lly
> an implementation issue, and partially a fundamental issue. Obviously
> --follow sucks pretty hard right now, and that could be fixed. Namely=
 it
> follows only a single file, and it interacts very badly with history
> simplification.
>
> But even with those things fixed, there will still be annoyances.
>
> It will still be _slower_ to turn it on all the time, for one[1]. And
> that's due to fundamental design decisions of the git data structure.

Does it really have to be? I mean, for whole-file rename-detection, if
we say that we automatically enable rename-detection (by default) as
we reach the first commit that doesn't have a given tree-entry, then
it would only kick in as we're about to terminate the log-output. And
since we're usually reading through a pager, it should means that it
takes a little bit more time before the user knows he's at the end of
the log. It shouldn't really affect the throughput of the data before
the point that becomes an annoyance, right?

At least that's the part that I find the most annoying with the
current rename detection; having to enable the flag as I reach the end
of the history for a file, often having to search through a lot of
commits again.
