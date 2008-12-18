From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv5 2/3] gitweb: add patches view
Date: Thu, 18 Dec 2008 17:23:43 +0100
Message-ID: <cb7bb73a0812180823y5249abcakd419d4fee9942d84@mail.gmail.com>
References: <1229422290-6213-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1229422290-6213-3-git-send-email-giuseppe.bilotta@gmail.com>
	 <7v4p12hv5q.fsf@gitster.siamese.dyndns.org>
	 <200812181033.57360.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Petr Baudis" <pasky@suse.cz>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 17:25:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDLgP-0004BZ-F8
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 17:25:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbYLRQXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 11:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbYLRQXr
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 11:23:47 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:4615 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040AbYLRQXq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 11:23:46 -0500
Received: by ey-out-2122.google.com with SMTP id 22so22495eye.37
        for <git@vger.kernel.org>; Thu, 18 Dec 2008 08:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=NnBboZU3683OrRKDCUIHdG1Vg+a34772b25YcMw4wsM=;
        b=QXK/py8z5KFmqTCK+Hmh7MyFSvZe0/6t8+2kXWQxX0kiw3D3STExKdSBqmg1liaYYT
         Abf0lyJSRuC9bFCaZRhSp/koaNZHApHlZDET0AH+ghWXjwPswfCEpiFC41sK1yub+sUZ
         gP4rxcnc9sJ8cnn4FsdiK6Pl8rJl3CQROM7Kw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=sU2w+c0mJa+B2Cp9SKyodel0K5vacjxaWTcV3GVwnCRDND5hq5h7FmQ+DPNfOD0Ada
         Gy9+W6RVBJ85kgEtBIKKyXIN5DGIxUIBn4gdSR+sAYftDYVZRgFczA/+6IgXTtVYQdvh
         DBv0xc1WRBCZq0byl6RfKTC5AHTYPgRl+Yzbg=
Received: by 10.210.92.8 with SMTP id p8mr2502222ebb.55.1229617423917;
        Thu, 18 Dec 2008 08:23:43 -0800 (PST)
Received: by 10.210.136.4 with HTTP; Thu, 18 Dec 2008 08:23:43 -0800 (PST)
In-Reply-To: <200812181033.57360.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103467>

On Thu, Dec 18, 2008 at 10:33 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Thu, 18 Dec 2008, Junio C Hamano wrote:
>> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>>
>> >  sub git_commitdiff {
>> >     my $format = shift || 'html';
>> > +   my %params = @_;
>> > ...
>> > +                   if ($params{-single}) {
>> > +                           push @commit_spec, '-1';
>> > +                   } else {
>> > +                           if ($patch_max > 0) {
>> > ...
>> > +                   }
>> > @@ -5625,6 +5635,10 @@ sub git_commitdiff_plain {
>> >
>> >  # format-patch-style patches
>> >  sub git_patch {
>> > +   git_commitdiff('patch', -single=> 1);
>> > +}
>>
>> Hmm, if you are changing the interface this way, wouldn't it make more
>> sense to also do this?
>>
>>       git_commitdiff(--format => 'patch', --single => 1);
>>       git_commitdiff(--format => 'html');
>
> The first argument (format) is _required_, second is _optional_;
> I'd rather use named parameters trick only for optional parameters.
> Because with more than one optional parameter function call begins
> to be cryptic; also flag (boolean) parameters are more readable
> when used as named parameters.

I have mixed feelings about this: on the one hand we have href() (say)
that takes all its params from a has, but on the other hand we have
esc_html() (say) that takes only additional options from a hash. I'm
personally more inclined towards the latter usage for git_commitdiff
(i.e. this patch) but since the other alternative is straightforward I
sent a v6 of the patchset which implements it.

-- 
Giuseppe "Oblomov" Bilotta
