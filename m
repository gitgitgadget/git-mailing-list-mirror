From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Migrating svn to git with heavy use of externals
Date: Tue, 08 Apr 2008 23:43:53 -0700
Message-ID: <7vhcebcyty.fsf@gitster.siamese.dyndns.org>
References: <47F15094.5050808@et.gatech.edu> <47FBB448.3060900@et.gatech.edu>
 <32541b130804081306q6e06af20u794357eba9d434e@mail.gmail.com>
 <47FBDA77.2050402@et.gatech.edu>
 <32541b130804081401n743f39c9o3f016da9dee2eb92@mail.gmail.com>
 <8FE3B7A7-4C2D-4202-A5FC-EBC4F4670273@sun.com>
 <32541b130804082033q55c795b5ieaa4e120956ff030@mail.gmail.com>
 <49E9DCEC-8A9E-4AD7-BA58-5A40F475F2EA@sun.com>
 <32541b130804082334s604b62b0j82b510c331f48213@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Roman Shaposhnik" <rvs@sun.com>, stuart.freeman@et.gatech.edu,
	git@vger.kernel.org
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 09 08:44:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjU3E-0000gq-MT
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 08:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752297AbYDIGoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 02:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752302AbYDIGoL
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 02:44:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45181 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297AbYDIGoL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 02:44:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EB66911983;
	Wed,  9 Apr 2008 02:44:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 1CCF0118F0; Wed,  9 Apr 2008 02:44:01 -0400 (EDT)
In-Reply-To: <32541b130804082334s604b62b0j82b510c331f48213@mail.gmail.com>
 (Avery Pennarun's message of "Wed, 9 Apr 2008 02:34:58 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79077>

"Avery Pennarun" <apenwarr@gmail.com> writes:

> On Wed, Apr 9, 2008 at 12:39 AM, Roman Shaposhnik <rvs@sun.com> wrote:
>>  Agreed. But I guess I'd be less confused if "git submodule" didn't muck
>>  with .git/config at all. Or are there any other consumers of the
>> information
>>  that it puts there (except itself)?
>
> That I don't know.  If there aren't any others, then I agree, I'm not
> sure what the whole .git/config messing is about.

Its actually the other way around.

In-tree .gitmodules is used to give hints to prime what is placed in
.git/config, which after initialized should serve as the authoritative
information on managed submodules as far as your repository is concerned.
"git submodule init" may be a handy way to do this "priming", but you do
not necessarily have to use it but instead manually adjust .git/config
yourself; this is so that you can configure remote url that is different
from what .gitmodules suggests to suite your local needs.

Although putting everything in a single repository could work, that does
not have to be the only way to work with submodules.  In fact, the basic
submodule design is trying very hard not to force you to grab objects that
are needed for all submodules when you are cloning the superproject, as
not cloning nor checking out any submodule is the default.
