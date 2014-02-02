From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH v4 3/4] setup: Add 'abspath_part_inside_repo' function
Date: Sun, 02 Feb 2014 12:21:58 +0100
Organization: Organization?!?
Message-ID: <871tzl2209.fsf@fencepost.gnu.org>
References: <20140131202142.GA9731@mule>
	<1391306351-13237-1-git-send-email-martinerikwerner@gmail.com>
	<1391306351-13237-4-git-send-email-martinerikwerner@gmail.com>
	<CACsJy8A8hardH7EaopY2Xu5Ob50mew3pJdqAr6fJsqyyhLQYMg@mail.gmail.com>
	<20140202111330.GB14729@mule>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 02 12:22:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9v7w-0005d3-0j
	for gcvg-git-2@plane.gmane.org; Sun, 02 Feb 2014 12:22:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbaBBLWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Feb 2014 06:22:11 -0500
Received: from plane.gmane.org ([80.91.229.3]:46587 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751049AbaBBLWK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 06:22:10 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1W9v7o-0005aZ-Vn
	for git@vger.kernel.org; Sun, 02 Feb 2014 12:22:08 +0100
Received: from x2f40a1f.dyn.telefonica.de ([2.244.10.31])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 12:22:08 +0100
Received: from dak by x2f40a1f.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 12:22:08 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x2f40a1f.dyn.telefonica.de
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:7z76rp1pNjt6+tkjNIH/WDz9Tu0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241361>

Martin Erik Werner <martinerikwerner@gmail.com> writes:

> On Sun, Feb 02, 2014 at 09:19:04AM +0700, Duy Nguyen wrote:
>> On Sun, Feb 2, 2014 at 8:59 AM, Martin Erik Werner
>> <martinerikwerner@gmail.com> wrote:
>> > +       /* check if work tree is already the prefix */
>> > +       if (strncmp(path, work_tree, wtlen) == 0) {
>> > +               if (path[wtlen] == '/')
>> > +                       memmove(path, path + wtlen + 1, len - wtlen);
>> > +               else
>> > +                       /* work tree is the root, or the whole path */
>> > +                       memmove(path, path + wtlen, len - wtlen + 1);
>> > +               return 0;
>> > +       }
>> 
>> No the 4th time is not the charm yet :) if path is "/abc/defghi" and
>> work_tree is "/abc/def" you don't want to return "ghi" as the prefix
>> here.
>
> Ah indeed, this should catch that:
>
> diff --git a/setup.c b/setup.c
> index 2270bd4..5817875 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -32,9 +32,11 @@ static inline int abspath_part_inside_repo(char *path)
>  	if (strncmp(path, work_tree, wtlen) == 0) {
>  		if (path[wtlen] == '/')
>  			memmove(path, path + wtlen + 1, len - wtlen);
> -		else
> +		else if (path[wtlen - 1] == '/' || path[wtlen] == '\0')

Is wtlen guaranteed to be nonzero?

-- 
David Kastrup
