From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH] tag: Use OPT_BOOL instead of OPT_BOOLEAN to allow one
 action multiple times
Date: Sat, 17 Aug 2013 16:01:37 +0100
Message-ID: <520F9051.4040600@gmail.com>
References: <1375207251-4998-1-git-send-email-stefanbeller@googlemail.com> <7va9l3x34f.fsf@alter.siamese.dyndns.org> <51F83010.2060804@googlemail.com> <7vfvuvvg0r.fsf@alter.siamese.dyndns.org> <51F8E81E.6000705@googlemail.com> <7vbo5itjfl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <stefanbeller@googlemail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 17 17:01:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAi0g-0007nc-MJ
	for gcvg-git-2@plane.gmane.org; Sat, 17 Aug 2013 17:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753536Ab3HQPBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Aug 2013 11:01:42 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:60081 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443Ab3HQPBl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Aug 2013 11:01:41 -0400
Received: by mail-we0-f174.google.com with SMTP id q54so2522439wes.19
        for <git@vger.kernel.org>; Sat, 17 Aug 2013 08:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=85MfHqhBUSUT/jkE2lFwOTfClONKePASyYPjXaj/DEs=;
        b=Frudrove0CplHhWz/I8O/dmQi6cFW6wODmvfb3ztb6HVVxZe74ex9tSsId5ydMQYsX
         zymE8Vz5+3EpoX0vERIx7Jc9vaT9d2qSDpi8LHJycLPAYu0mgi1e15EbSU/ApMxULObp
         FtONt6xJvzB+VNR1ELI9bTHVcscgxxegx601jNBLUy5uUTWJKtwgVC2BPsxilQRzoVu5
         W5K7zvKYYsJTz/qRSmgc3G8eIa9kqcGSUThahZXecrHPNdcJRqcdHsy2bE7BWQyF/Rye
         jxFrDPAVORvsDJETAKQdrXs5pI5IUmj2nyrdP4a0OR8vMWEJDsyCNVh90ZOOE2e69GqY
         6D9g==
X-Received: by 10.180.13.13 with SMTP id d13mr2073874wic.34.1376751700171;
        Sat, 17 Aug 2013 08:01:40 -0700 (PDT)
Received: from marcovaldo.dub.corp.google.com ([2620:0:1040:205:8a51:fbff:fe5c:1cad])
        by mx.google.com with ESMTPSA id z2sm3668421wiv.11.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 17 Aug 2013 08:01:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130804 Thunderbird/17.0.8
In-Reply-To: <7vbo5itjfl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232457>

(Going through old mail today, sorry for the late reply)

On 08/01/2013 12:10 AM, Junio C Hamano wrote:> Stefan Beller 
<stefanbeller@googlemail.com> writes:
 >
 >> On 07/31/13 00:28, Junio C Hamano wrote:
 >>>
 >>> we could just do
 >>>
 >>> #define OPT_CMDMODE(s, l, v, h) \
 >>>      { OPTION_CMDMODE, (s), (l), (v), NULL, \
 >>>        (h), PARSE_OPT_NOARG|PARSE_OPT_NONEG, NULL, (s) }
 >>>
 >>
 >> I agree that's a better proposal than mine.
 >
 > By the way, I haven't convinced myself that it is a good idea in
 > general to encourage more use of command mode options, so I am a bit
 > reluctant to add this before knowing which direction in the longer
 > term we are going.
 >
 >   - Some large-ish Git subcommands, like "git submodule", use the
 >     mode word (e.g. "git submodule status") to specify the operation
 >     mode (youe could consider "status" a subsubcommand that
 >     "submodule" subcommand takes).  These commands typically began
 >     their life from day one with the mode words.
 >
 >   - On the other hand, many Git subcommands, like "git tag", have
 >     "the primary operation mode" (e.g. "create a new one" is the
 >     primary operation mode for "git tag"), and use command mode
 >     options to specify other operation modes (e.g. "--delete").
 >     These commands started as single purpose commands (i.e. to
 >     perform their "primary operation") but have organically grown
 >     over time and acquired command mode options to invoke their
 >     secondary operations.
 >
 > As an end user, you need to learn which style each command takes,
 > which is an unnecessary burden at the UI level.  In the longer term,
 > we may want to consider picking a single style, and migrating
 > everybody to it.  If I have to vote today, I would say we should
 > teach "git submodule" to also take command mode options (e.g. "git
 > submodule --status" will be understood the same way as "git
 > submodule status"), make them issue warnings when mode words are
 > used and encourage users to use command mode options instead, and
 > optionally remove the support of mode words at a large version bump
 > like 3.0.
 >
 > One clear advantage mode words have over command mode options is
 > that there is no room for end user confusion.  The first word after
 > "git subcmd" is the mode word, and you will not even dream of asking
 > "what would 'git submodule add del foo' do?" as it is nonsensical.
 > The command mode options, on the other hand, gives too much useless
 > flexibility to ask for nonsense, e.g. "git tag --delete --verify",
 > "git tag --no-delete --delete", etc., and extra code needs to detect
 > and reject combinations.  But commands that took mode options cannot
 > be easily migrated to take mode words without hurting existing users
 > and scripts (e.g. "git tag delete master" can never be a request to
 > delete the tag 'master', as it is a request to create a tag whose
 > name is 'delete' that points at the same object as 'master' points
 > at).
 >
Why not encourage the use of a standardized '--action' option instead?
This can work with lesser compatibility headaches for both the commands
taking mode options and the commands taking mode words:

   "git submodule init"   becomes  "git submodule --action=init"
   "git tag --delete TAG" becomes  "git tag --action=delete TAGNAME"

Commands that have a "primary operation mode" can keep the use
of --action optional, while commands that have no such sensible
primary mode can make it mandatory (again, this gives more compatibility 
with the existing syntax).  And the old syntax
can be supported in parallel to the new one for a potentially
indefinite time; albeit, if I were to propose a timetable, I'd
got for:

   - Git 2.0: the new syntax is introduced
   - Git 2.x: any use the old syntax starts to trigger warnings
     (which can be silenced with a config option)
   - Git 3.0: any use the old syntax starts to trigger fatal
     errors (which can be turned into mandatory warnings with
     a config option)
   - Git 4.0: any use the old syntax starts to trigger
     mandatory fatal errors.
   - Git 4.x: Remove any handling of the old syntax.

Just my 2 cents,
   Stefano
