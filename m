From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] whitespace: fix initial-indent checking
Date: Sun, 16 Dec 2007 19:16:44 +0100
Message-ID: <200712161916.44715.jnareb@gmail.com>
References: <7vodd4fb2f.fsf@gitster.siamese.dyndns.org> <25FDB05F-3E85-4E08-90BE-1BE468C07805@wincent.com> <20071216162637.GA3934@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio Hamano <junkio@cox.net>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sun Dec 16 19:17:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3y39-00028e-5x
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 19:17:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932943AbXLPSQv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Dec 2007 13:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932916AbXLPSQv
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 13:16:51 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:3176 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932915AbXLPSQu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 13:16:50 -0500
Received: by fg-out-1718.google.com with SMTP id e21so197653fga.17
        for <git@vger.kernel.org>; Sun, 16 Dec 2007 10:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=bSLPIxiQgk0W7YgYWo4JCels4ozo46sSBZldIG6k0Gw=;
        b=ulKD2ifH6d6OssZ6WZK9mtrZwoXl4799KtFZQxGnuFoZjfIXxmJEa+oVyIq7KgqV+JuDUu26SHkBrHnE2KBFeHgi7KiyO9BSdeiEe3SAoDL7rZO2rCwxof0COLU+hqtUVxoiFyaO6g46bzPjglAj3j5Bo92WTDZYBpcVrR88YpI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jvz+QsN/Psga3UGqkUX9G9Sia+5HZHHf6DNBbBuaS2VlR8ohi4twi1NAlEfxwGpSCdH9uQKJEie1uQgdA6sExc1KG7zaSgYpEjqUPXLOEKsujUutzcfwqOMif/2r0BikAYskWCPBR7T2cdRweVQpmOOzEAunnP7T8nSLk/DnGCU=
Received: by 10.86.51.2 with SMTP id y2mr5517487fgy.56.1197829008849;
        Sun, 16 Dec 2007 10:16:48 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.189.199])
        by mx.google.com with ESMTPS id e20sm626479fga.2007.12.16.10.16.44
        (version=SSLv3 cipher=OTHER);
        Sun, 16 Dec 2007 10:16:46 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20071216162637.GA3934@fieldses.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68474>

J. Bruce Fields wrote:
> On Sun, Dec 16, 2007 at 11:00:55AM +0100, Wincent Colaiuta wrote:
>> El 16/12/2007, a las 10:08, Jakub Narebski escribi=C3=B3:
>>
>>> J. Bruce Fields wrote:
>>>
>>>> This allows catching initial indents like '\t        ' (a tab foll=
owed
>>>> by 8 spaces), while previously indent-with-non-tab caught only ind=
ents
>>>> that consisted entirely of spaces.
>>>
>>> I prefer to use tabs for indent, but _spaces_ for align. While prev=
ious,
>>> less strict version of check catches indent using spaces, this one =
also
>>> catches _align_ using spaces.
>=20
> No, the previous version didn't work for the align-with-spaces case
> either.  Consider, for example,
>=20
> struct widget *find_widget_by_color(struct color *color,
>                                     int nth_match, unsigned long flag=
s)
>=20
> If following a "indent-with-tabs, align-with-spaces" policy, then the
> initial whitespaace on the second line should be purely spaces
> (otherwise adjusting the tab stops would ruin the alignment).  But
> indent-with-non-tab would flag this as incorrect even before my fix.

Yes, this is (if we want "indent with tab, align with spaces") false
positive even with current version of indent-with-non-tab policy, but
it is _rare_ false positive.

It is useful because it catches quite common "indent with spaces only",
for example if MTA or editor replaces tabs with spaces, or if editor
preserves whitespace but it uses spaces for indent.

So for me this version is a good compromise between false positives
and catching real indent whitespace errors. The version proposed has
IMHO too many false positive, while I guess not catching much more
errors in practice.

>> I'd say that Jakub's is a fairly common use case (it's used in many =
places=20
>> in the Git codebase too, I think) so it would be a bad thing to chan=
ge the=20
>> behaviour of "indent-with-non-tab".
>>
>> If you also want to check for "align-with-non-tab" then it really sh=
ould be=20
>> a separate, optional class of whitespace error.
>=20
> I would agree with you if it were not for the fact that if you're usi=
ng
> an "indent-with-tabs, align-with-spaces" policy then the only indent
> whitespace problems that you can flag automatically are space-before-=
tab
> problems; anything else requires knowledge of the language syntax.

Unfortunately quite true (by the way, doesn't new version of
"align-with-non-tab" do not work for Python sources?)

Perhaps it should be called "no-8spaces" os something like that: is the
width (in columns) of a tab character configurable, by the way?

> So indent-with-non-tab has only ever been useful for projects that
> insist on tabs for all sequences of 8 spaces in the initial whitespac=
e.

IMVVHO the new version of "indent-with-non-tab" (aka "no-8-spaces") is
useful _only_ for such project, while old version not only (see comment
above).

--=20
Jakub Narebski
Poland
