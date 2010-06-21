From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2010, #03; Fri, 18)
Date: Mon, 21 Jun 2010 12:16:44 -0700
Message-ID: <7vk4psgpr7.fsf@alter.siamese.dyndns.org>
References: <7v7hlvyi50.fsf@alter.siamese.dyndns.org>
 <AANLkTinB4N6xXm7_Locp-xJyN8Nkew_7t16XhjVi_GlB@mail.gmail.com>
 <7v7hltvcfy.fsf@alter.siamese.dyndns.org>
 <AANLkTiksOHr2m4HCPp8779VG95zexvYwgE86MsFzBJxF@mail.gmail.com>
 <7v631ci6ex.fsf@alter.siamese.dyndns.org>
 <AANLkTilINSK78ds1A3ZK1kdqlHf8S-lLrVboabsQLua_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 21 21:17:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQmUO-0003wy-M3
	for gcvg-git-2@lo.gmane.org; Mon, 21 Jun 2010 21:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758123Ab0FUTQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jun 2010 15:16:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46399 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638Ab0FUTQx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jun 2010 15:16:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D6A5BD9CC;
	Mon, 21 Jun 2010 15:16:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=srw25BI6hPIJ74UwJwJGofTNC+Y=; b=AYJQrj8S27iETWJBzRyciA+
	9j3+/4/nkYTrQ3t1jzScwABle3ut49DGmMgorkH+PAQI+iq2SnhpgXNGFiYYQHV1
	Pi00Lq2h1J7yQUShOFw0/WPMAAjqefO4eMtNYzkNmp+sZmBS5mi77BHCCRmeUBxI
	sqGt2rhVWMy768xPcPAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=p9s3rw+h1rRmrP3sJRIhXTzh3SNS6QCtUokzY4euigWZtiw7y
	IyCx7+iZzyOEIyMYAxponMkw6BZsoIVBFCQb6PvK/9jHPQtTFoFblZRJRUD7+zFH
	mld6q2t+7yayrpgS1Di++Z6gLyVnJrzlTcW5/zGICBdsdgGSc6VLgFJ3r4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D8B56BD9CB;
	Mon, 21 Jun 2010 15:16:48 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 040CFBD9CA; Mon, 21 Jun
 2010 15:16:45 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8A3AD408-7D69-11DF-B056-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149436>

Pavan Kumar Sunkara <pavan.sss1991@gmail.com> writes:

> The right one is given below.
> http://mid.gmane.org/1275573356-21466-3-git-send-email-pavan.sss1991@gmail.com

Oh, I do have three issues with that one.

#1. Command line should be able to override configuration

You currently have:

 . By default without command line override nor configuration, old
   behaviour of "refresh the gitweb.conf every time" stands;

 . You can tell it to keep the configuration with a command line option;

 . If you are tired of having to give the command line option every time,
   you can set a configuration variable instead.

The first bullet is fine; it is called "backward compatibility."  The
second one is also good.  "We allow a non-default behaviour in a rare case
with a command line option" is a good change.

But the third one makes the story quite different.

Adding a configuration needs to be done a lot more carefully.  If somebody
has configured instaweb.overwrite to false, you must give him a way to
override that from the command line.

IOW, you must at least support "git instaweb --no-reuse-config" in [PATCH
2/3].

If you anticipate that some people may get tired of having to give that
option all the time, it is possible that the choice of the original
default behaviour was wrong, at least for some people.  We might even want
to make "instaweb.overwrite" default to "false" in later versions.

Having command line override of configured default becomes even more
important for that transition to happen smoothly.  If a user has to use
older and newer versions of git across that default flip, it would give
him a reliable behaviour to say --[no-]reuse-config explicitly from the
command line.

#2. The subject of the patch should spell the name of the new variable on
   it.  But this is an artifact of a larger design issue; see below.

#3. Naming.

If you are going to make an configuration variable, its name should be
consistent with the command line option (I think Pasky said something
similar).  Your command line is '--reuse-config' but your configuration is
'(instaweb.)overwrite'.  Do you think these click with each other for
people other than you?  Wouldn't it be much more consistent if the above
were:

 . By default without command line override nor configuration, old
   behaviour of "refresh the gitweb.conf every time" stands;

 . You can tell it to keep the configuration by --no-overwrite-config
   option; to regenerate the config, say --overwrite-config (which is the
   current default but we _might_ change the default in the future if "no
   overwrite" is found to be more sensible by larger audience).

 . If you are tired of having to give --no-overwrite-config every time,
   you can say "[instaweb] overwriteConfig = false".

I know "overwrite-config" is a bit too long, and you would need to come up
with a shorter name (perhaps "reconfig"???) but the point is that we
should make it easy to guess the corresponding configuration variable name
given the command line option and vice-versa.

> It's not acked but it's not commented. So I am guessing nobody has
> problem with it.

That is not the right way to interpret lack of responses.  "Nobody is
interested in that patch" is the default interpretation.
