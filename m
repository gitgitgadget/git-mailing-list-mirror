From: =?ISO-8859-1?Q?Johan_S=F8rensen?= <johan@johansorensen.com>
Subject: Re: [PATCH] Introduce a filter-path argument to git-daemon, for doing 
	custom path transformations
Date: Thu, 12 Mar 2009 11:26:12 +0100
Message-ID: <9e0f31700903120326s28acbc67ufefff344c9098ca@mail.gmail.com>
References: <1236784647-71388-1-git-send-email-johan@johansorensen.com>
	 <49B7DFA1.4030409@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 12 11:28:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhi9T-000517-11
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 11:28:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756040AbZCLK0U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 06:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756045AbZCLK0T
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 06:26:19 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:39619 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756023AbZCLK0R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 06:26:17 -0400
Received: by nf-out-0910.google.com with SMTP id d21so80049nfb.21
        for <git@vger.kernel.org>; Thu, 12 Mar 2009 03:26:13 -0700 (PDT)
Received: by 10.210.37.16 with SMTP id k16mr3145370ebk.60.1236853572967; Thu, 
	12 Mar 2009 03:26:12 -0700 (PDT)
In-Reply-To: <49B7DFA1.4030409@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113038>

On Wed, Mar 11, 2009 at 4:58 PM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> Johan S=F8rensen schrieb:
>> This buys us a lot of flexibility when it comes to managing differen=
t
>> repositories, possibly located in many different dirs, but with a un=
iform
>> url-structure to the outside world.
>
> It's the first time that I see a deamon with this feature - except pe=
rhaps
> Apache's ModRewrite. Are you sure you are not working around your pro=
blem
> at the wrong place?
>
> Doesn't --interpolated-path already solve your problem? If not, then =
you
> at least you must describe in the documentation the use-cases when
> --path-filter should be preferred.

Maybe I am barking up the wrong tree, but here's my real-world use
case: I'm currently working on some bigger changes for gitorious.org,
where the repository url-structure could potentially change over time,
as a consequence of various features. Using the path-filter script I
can keep the old urls around and still working, and I can map any url
to a on-disk uniquely hashed path, so I don't have to move the files
around, maintain symlinks and so forth for information the gitorious
application already has nicely structured and easy to lookup.

I know these may be highly specialized needs, but so is
interpolated-path for the common user. I think this patch could be
useful for anyone else wanting to set up a flexible repo hosting
system. I think the url-structure is a major part of the UI for any
app exposing them, even for a git-daemon, so the mod_rewrite
comparison isn't too far fetched in my opinion...

> Your implementation does not pass the target hostname to the script, =
but
> it should; otherwise you lose flexibility (for virtual hosting).

Good point. I've added the hostname as well as the service name as
arguments for the script.

>> + =A0 =A0 switch ((pid =3D fork())) {
[snip]
>
> Use start_command()/finish_command() instead of rolling your own fork=
/exec
> combo.

Ah nice! I'm sending an updated patch.


>
> -- Hannes
>

Cheers,
JS
