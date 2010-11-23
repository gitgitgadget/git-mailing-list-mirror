From: Scott Chacon <schacon@gmail.com>
Subject: Re: disabling PROPFIND when using smart http
Date: Tue, 23 Nov 2010 11:50:56 -0800
Message-ID: <AANLkTikmAGd4Dyv7LijbnKX5Wywzf=zRX2Kpv+6MUZtu@mail.gmail.com>
References: <AANLkTikwqtPDDk6i0nMKJiXn5cc3DmTGYp0==daX96yd@mail.gmail.com>
	<20101123161018.GB10420@LK-Perkele-V2.elisa-laajakaista.fi>
	<AANLkTikoGS4X8YbNgLT=Akx5RBj2d4Uybdx5QnJ+CWNo@mail.gmail.com>
	<AANLkTimvKg3mwfZUoRHoj=uW0FxGS=meF-ChLJKEtHcp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 20:51:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKytr-0004Af-1V
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 20:51:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936Ab0KWTvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 14:51:01 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:36954 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893Ab0KWTu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 14:50:58 -0500
Received: by ewy5 with SMTP id 5so2685311ewy.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 11:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=iX5nzHLK//E+/P2IRIaSWimztJA7Z1311Awc0DNUk/4=;
        b=kL6OWPsxjVyU3OlSw8+Ned1VY4hnz5wer8uT+mRNhjJoy17v2XSjwTCAQSZoOAGKHo
         D3+1i5aY3jtY8dyVRf2+KlVPfBRT20MhyB+oABpy/9FkApm+GPT+DDVGKsAyqQ9RZRvW
         L5GH6UR+FfeYuXxfajBTtc503pxucMsJwbilo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=DBzpE5nSAzGt/CDvBbdgnDlO0bcHks4S8eqKHsKuVjux02xDoiVdHB/jyyv/xBZfrB
         CTsDOSuqdxCR6pBQ8nMIvNeY7jzogJkx2LrJKXPDvgtkZD8G/UXu5qM/Nk6LS6DUKPa0
         SrP0gz5OawnfX409qpu+MufU0FwIh18Tt/ck4=
Received: by 10.14.48.12 with SMTP id u12mr642894eeb.34.1290541856970; Tue, 23
 Nov 2010 11:50:56 -0800 (PST)
Received: by 10.14.119.197 with HTTP; Tue, 23 Nov 2010 11:50:56 -0800 (PST)
In-Reply-To: <AANLkTimvKg3mwfZUoRHoj=uW0FxGS=meF-ChLJKEtHcp@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162016>

Hey,

On Tue, Nov 23, 2010 at 11:40 AM, Sitaram Chamarty <sitaramc@gmail.com> wrote:
>
> Well it was someone else, but the pastie he has sent was
> http://pastebin.com/eaB0G1gx -- which may or may not help, because it
> doesn't seem to show the response *body*, only the headers.
>
> If that doesn't help I'll try and reproduce the problem myself first.

Still, it's enough.  The request is obviously not getting back to the
Git CGI for some reason.  There are a number of headers that should
have been returned after the first authed GET to /info/refs (lines
35-42 have the servers response).  It should have:

< Content-Type: application/x-git-receive-pack-advertisement
< Pragma: no-cache
< Cache-Control: no-cache, max-age=0, must-revalidate

The Git CGI will set all of those.  Since it's not, and it's setting
things like ETags, it's not the Git CGI you're communicating with.
Check the apache logs and see why it's not routing the request to the
cgi.

Scott
