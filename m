From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATHv2 7/8] gitweb: embed snapshot format parameter in PATH_INFO
Date: Sat, 1 Nov 2008 13:57:52 +0100
Message-ID: <cb7bb73a0811010557u31ce5f69o9b4b0d53a102498a@mail.gmail.com>
References: <1224188831-17767-6-git-send-email-giuseppe.bilotta@gmail.com>
	 <1224426270-27755-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1224426270-27755-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <200811010118.14191.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 01 13:59:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwG4S-00026v-Ks
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 13:59:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbYKAM5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 08:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbYKAM5z
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 08:57:55 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:38015 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbYKAM5y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 08:57:54 -0400
Received: by yw-out-2324.google.com with SMTP id 9so722752ywe.1
        for <git@vger.kernel.org>; Sat, 01 Nov 2008 05:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=RPYayRoeGgp2XbhIgohVzlBndS9+rcA7kwG6LqFgc74=;
        b=kkcq0OKDw0WCjB5Ww89Nm8QR9nWctqezy01i0NDpxmUBsOR73aHAixMLene5IoI/mz
         LREW3mbo0IowaY5CXhy3tXP1Qy/d2h+jkWAS39mqT89UI1rGCbbkbKaRyhAvF/A4xNgY
         yH3knKId9WWpyW+O2atApAZd8BB9pa//ZxhRo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=CQJGMITabUdFYpQqS+GvBdKAMwJb4Dfe0jobATTS3ylywltSuQf19LcaYqTd5El+yG
         CbAxJroswjVZ56JmnQeBHIuXZ6j33SWObyxF6OT0LZERhFGYbb2ZhYYyfptigwgEup3U
         AXFDzDI8PNqPSuZbYXYagQoUIeimoXse94bVw=
Received: by 10.151.114.6 with SMTP id r6mr4189418ybm.150.1225544272729;
        Sat, 01 Nov 2008 05:57:52 -0700 (PDT)
Received: by 10.150.155.12 with HTTP; Sat, 1 Nov 2008 05:57:52 -0700 (PDT)
In-Reply-To: <200811010118.14191.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99739>

On Sat, Nov 1, 2008 at 1:18 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Sun, 19 Oct 2008, Giuseppe Bilotta wrote:
>
> I'm sorry for the delay.

No problem.

>> When PATH_INFO is active, get rid of the sf CGI parameter by embedding
>> the snapshot format information in the PATH_INFO URL, in the form of an
>> appropriate extension.
>
> The question is: should we use format suffix (e.g. 'tar.gz'),
> or format name (e.g. 'tgz')?  The latter is later easier to parse,
> see comments to first patch in better snapshot support for path_info.

I think it's essentially a matter of deciding which extension to use
by default on output, and accepting either extension on input.


>> +             # since we destructively absorb parameters, we keep this
>> +             # boolean that remembers if we're handling a snapshot
>> +             my $is_snapshot = $params{'action'} eq 'snapshot';
>> +
>
> Side note: we destructively absorb parameters, because parameters
> which are not absorbed are then used to generate query string part
> of URL.
>
> Deleting parameter but remembering the fact that it was used is one
> (but not only) solution.

Well, in the specific case of the 'action' parameter we could just
keep it around and only discard it at the end.

>> +                     if (!$fmt) {
>> +                             my @snapshot_fmts = gitweb_check_feature('snapshot');
>> +                             @snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);
>> +                             $fmt = $snapshot_fmts[0];
>> +                     }
>
> I anderstand that the above code is improved with new patch?

Yup, I followed your suggestion of putting the refactoring earlier.

>> +                     $href .= $known_snapshot_formats{$fmt}{'suffix'};
>
> Again: should we use snapshot prefix, or snapshot name, which means here
> do we use $known_snapshot_formats{$fmt}{'suffix'}; or just $fmt; ?

I really don't know, either is fine for me.

Maybe using $fmt has the benefit that it copes better with some buggy
versions of some browser (like Opera) that tend to strip the .gz from
.tar.gz files ...


-- 
Giuseppe "Oblomov" Bilotta
