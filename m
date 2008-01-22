From: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
Subject: Re: [PATCH] [RFC] Design for pathname encoding gitattribute [RESEND]
Date: Tue, 22 Jan 2008 10:13:12 +0100
Message-ID: <b77c1dce0801220113y3f33c7fjf8fd0cd2c2763274@mail.gmail.com>
References: <20080122050215.DE198200A2@wilber.wgtn.cat-it.co.nz>
	 <7vlk6iv0ik.fsf@gitster.siamese.dyndns.org>
	 <7vr6gatidd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Sam Vilain" <sam.vilain@catalyst.net.nz>, git@vger.kernel.org,
	"Peter Karlsson" <peter@softwolves.pp.se>,
	"Mark Junker" <mjscod@web.de>,
	"Pedro Melo" <melo@simplicidade.org>,
	"Martin Langhoff" <martin.langhoff@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Dmitry Potapov" <dpotapov@gmail.com>,
	"Kevin Ballard" <kevin@sb.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 10:13:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHFCY-0001zL-3W
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 10:13:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753982AbYAVJNU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Jan 2008 04:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754007AbYAVJNU
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 04:13:20 -0500
Received: from hs-out-0708.google.com ([64.233.178.247]:41256 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752894AbYAVJNR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jan 2008 04:13:17 -0500
Received: by hs-out-2122.google.com with SMTP id 54so2066806hsz.5
        for <git@vger.kernel.org>; Tue, 22 Jan 2008 01:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=8RHdD9+R3zP/R9RK2lwR+LdFVWiaGXbIL1+9x2GYavU=;
        b=b5/u2oDgCr8hXuRPNgMlPYSwaSfim4r8eNCPehVk/z2Ul801Knm0toG90xj71nV8ZiRa2ZwpGD9Etmt3WH0hYubXqyiuc7EdmF8ORMH4yKdw+5XgwdMK5i1/vKE03wIxxYTOGX67tCqRilWFG56iV+8UeX+YEE/7XBSHBv7AKA4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=egLl8WfNDJ0RTHiegtigrPRZXknJmXF9FVu2SxOmTUAqw4zkAlIYqF90yqD5zbp547J8bvNqYYJ0z8kmS8HhYcrStFbjIJopPrwr7twMmRo+V5nGeon4sB43DS04M7Hlcm5KWIbAUVyEFW4GRMkrG3nT29ME+n2WZDaNd1909Rc=
Received: by 10.142.194.1 with SMTP id r1mr3761237wff.197.1200993192404;
        Tue, 22 Jan 2008 01:13:12 -0800 (PST)
Received: by 10.142.212.20 with HTTP; Tue, 22 Jan 2008 01:13:12 -0800 (PST)
In-Reply-To: <7vr6gatidd.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71434>

On 22/01/2008, Junio C Hamano wrote:
> If the project uses UTF-8-NFC, we would need to adjust check-in
> and check-out codepath like Linus's readdir(3) hack suggested,
> but that needs to be done only on HFS+.  Of course, the project
> participants need to be careful not to create files that HFS+
> cannot handle (two paths that happen to be equivalent strings
> should not be created), but I do not think that is such a big
> issue as some people seem to make a big deal out of.  If you

Right, I don't see that as a big issue -- for new files. But we can hav=
e
files that were created in the past as non-handleable by HFS+, and late=
r
renamed to something more portable.

More generally, the consensus encoding might change over time. We can
imagine a project which contains, say, a test file which a latin-1 name=
,
that gets later renamed to a UTF-8 name, (due to a project policy
change), but making necessary to adjust the said test. A checkout of th=
e
earlier version would have that test failing. (But maybe I'm just
handwaving towards a non-existent problem here. I'd consider the issue
as minor anyway.)

> want to be interoperable with different filesystems, you should
> not create two paths that are different only in case, and if
> there are participants who are on such a filesystem, the mistake
> is quickly spotted and corrected.  It happened in git.git to a
> file other than that infamous M=E4rchen.  It's exactly the same
> issue [*1*].
>
> In short, initially I did not like Linus's readdir(3) hack very
> much, but the more I think about it, I like it the better.
>
> We pick a reasonable default (i.e. "no conversion") at the
> technical level, and recommend (but do not pay for the overhead
> of enforcing) a reasonable normalization as the BCP at the human
> level.  Only on filesystems that mangle the pathnames, or if you
> want legacy encodings on the filesystem, we would need to pay
> overhead for conversion and help people with actual code to do
> so.
>
> To support the above scenarios, I think each instance of
> repository needs to be able to say "this path (specified with a
> matching pattern in the filename encoding) should be converted
> this way coming in, and that way going out."  UTF-8 only project
> would have NKC<->NKD on HFS+ partition, and nothing on
> everywhere else.  EUC-JP project that checks out as-is would
> specify nothing either, but people on Shift_JIS platforms would
> locally specify that EUC-JP <-> Shift_JIS conversion to be made.

Sounds sane, except maybe the part where you specify paths with a
pattern. Do you really need this layer of complexity? Pattern matching
in different encodings has proven to be troublesome. Usually that's
where UTF-8 normalisation rules and locale-specific behaviours kick in,
esp. when you're starting to use \w or \d characters classes, or case
insensitivity. For example, if you want to do it correctly, "I" will
match /i/ case-insensitively, except in Turkish locales... (Sorry, I'm
just handwaving again here...)
