From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: [PATCH v2 00/14] Sparse checkout
Date: Tue, 23 Sep 2008 13:06:47 +0200
Message-ID: <adf1fd3d0809230406r598f6d1l41cd860568de761f@mail.gmail.com>
References: <1221904913-25887-1-git-send-email-pclouds@gmail.com>
	 <m31vzen4v5.fsf@localhost.localdomain>
	 <fcaeb9bf0809201033o1e9298a8ob135c68228b77218@mail.gmail.com>
	 <200809202001.28383.jnareb@gmail.com>
	 <fcaeb9bf0809201248w2850a243n50596dda3121f2c@mail.gmail.com>
	 <7vzlm21n83.fsf@gitster.siamese.dyndns.org>
	 <fcaeb9bf0809210311x7e9337fbmd978e95aa7998525@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 13:08:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki5kN-00014k-SW
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 13:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbYIWLGu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 07:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbYIWLGu
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 07:06:50 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:20557 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178AbYIWLGu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 07:06:50 -0400
Received: by nf-out-0910.google.com with SMTP id d3so676008nfc.21
        for <git@vger.kernel.org>; Tue, 23 Sep 2008 04:06:47 -0700 (PDT)
Received: by 10.103.233.4 with SMTP id k4mr3591426mur.48.1222168007525;
        Tue, 23 Sep 2008 04:06:47 -0700 (PDT)
Received: by 10.102.247.10 with HTTP; Tue, 23 Sep 2008 04:06:47 -0700 (PDT)
In-Reply-To: <fcaeb9bf0809210311x7e9337fbmd978e95aa7998525@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96545>

On Sun, Sep 21, 2008 at 12:11 PM, Nguyen Thai Ngoc Duy
<pclouds@gmail.com> wrote:
> On 9/21/08, Junio C Hamano <gitster@pobox.com> wrote:
>> "Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:
>>
>>  > On 9/21/08, Jakub Narebski <jnareb@gmail.com> wrote:
>>
>> > ...
>>
>> >>  >>  BTW I think that the same rules are used in gitattributes, aren't
>>  >>  >>  they?
>>  >>  >
>>  >>  > They have different implementations. Though the rules may be the same.
>>  >>
>>  >> Were you able to reuse either one?
>>  >
>>  > No. .gitignore is tied to read_directory() while .gitattributes has
>>  > attributes attached. So I rolled out another one for index.
>>
>>
>> I am sorry, but that sounds like a rather lame excuse.  It certainly is
>>  possible to introduce an "ignored" attribute and have .gitattributes file
>>  specify that, instead of having an entry in .gitignore file, if you teach
>>  read_directory() to pay attention to the attributes mechanism.  If we had
>>  from day one that a more generic gitattributes mechanism, I would imagine
>>  we wouldn't even had a separate .gitignore codepath but used the attribute
>>  mechanism throughout the system.
>>
>>  Now I do not think we are ever going to deprecate gitignore and move
>>  everybody to "ignored" attributes, because such a transition would not buy
>>  the end users anything, but it technically is possible and would have been
>>  the right thing to do, if we were building the system from scratch.  We
>>  still could add it as an optional feature (i.e. if a path has the
>>  attribute that says "ignored" or "not ignored", then that determines the
>>  fate of the path, otherwise we look at gitignore).
>>
>>  I wouldn't be surprised if an alternative implementation of your code to
>>  assign "sparseness" to each path internally used "to-be-checked-out"
>>  attribute, and used that attribute to control how ls-files filters its
>>  output.
>>
>>  A better excuse might have been that "I am not reading these patterns from
>>  anywhere but command line", but that got me thinking further.
>
> That "from command line" piece makes a bit of difference. For example
> patterns separated by colons and backslash escape, but that does not
> stop it from reusing attr.c.
>
>>  How would that --narrow-match that is not stored anywhere on the
>>  filesystem but used only for filtering the output be any more useful than
>>  a grep that filters ls-files output in practice?
>
> Well, it works exactly like 'grep' internally.
>
>>  I would imagine it would be much more useful if .git/info/attributes can
>>  specify "checkout" attribute that is defined like this:
>>
>>         `checkout`
>>         ^^^^^^^^^^
>>
>>         This attribute controls if the path can be left not checked-out to the
>>         working tree.
>>
>>         Unset::
>>                 Unsetting the `checkout` marks the path not to be checked out.
>>
>>         Unspecified::
>>                 A path which does not have any `checkout` attribute specified is
>>                 handled in no special way.
>>
>>         Any value set to `checkout` is ignored, and git acts as if the
>>         attribute is left unspecified.
>>
>>  Then whenever a new path enters the index, you _could_ check with the
>>  attribute mechanism to set the CE_NOCHECKOUT flag.  Just like an already
>>  tracked path is not ignored even if it matches .gitignore pattern, a path
>>  without CE_NOCHECKOUT that is in the index is checked out even if it has
>>  checkout attribute Unset.
>>
>>  Hmm?
>
> Well I think people would want to save no-checkout rules eventually.
> But I don't know how they want to use it. Will the saved rules be hard
> restriction, that no files can be checked out outside defined areas?
> Will it be to save a couple of keystrokes,   that is, instead of
> typing "--reset-sparse=blah" all the time, now just "--reset-sparse"
> and default rules will be applied? Your suggestion would be the third,
> applying on new files only.
>
> Anyway I will try to extend attr.c a bit to take input from command
> line, then move "sparse patterns" over to use attr.c.


While I agree that the checkout attr looks like an attribute (so
reusing attr.c is a good idea) and $GIT_DIR/info/gitattributes seems a
good place to specify them, I think it will be better in the config
$GIT_DIR/config. There it is clear that it is a local thing and you
have "git config" to read and write them. Additionally you could have
different patterns in the config (sparse.default, sparse.doc,
sparse.src,...), although maybe it is not very useful.

I think the main UI to sparse checkout should be a default sparse
pattern that is used for "all" commands, like merge, reset, and
checkout. Now it is too easy to escape from the sparse checkout, when
you merge or checkout a branch with new files, when doing a "git reset
--hard" (when you abort a failed merge), or when doing a diff
(specially when you pull).

Santi
