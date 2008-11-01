From: "Elijah Newren" <newren@gmail.com>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI revamp
Date: Sat, 1 Nov 2008 13:42:40 -0600
Message-ID: <51419b2c0811011242k439c1504ve15dc2faff262224@mail.gmail.com>
References: <1225338485-11046-1-git-send-email-sam@vilain.net>
	 <20081030143918.GB14744@mit.edu> <vpqmygmw1mr.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Theodore Tso" <tytso@mit.edu>, "Sam Vilain" <sam@vilain.net>,
	git@vger.kernel.org
To: "Matthieu Moy" <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sat Nov 01 20:47:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwMRB-0003ap-5U
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 20:47:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbYKATmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 15:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751866AbYKATmm
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 15:42:42 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:60416 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930AbYKATml (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 15:42:41 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1858933rvb.1
        for <git@vger.kernel.org>; Sat, 01 Nov 2008 12:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=4Tvvf7hr5JZC+Tv64TvVltuirCQHuNWbqfQjn1PoR04=;
        b=jKMLq1lRtiuVGO96scUXS23tc8svuZ48DXN4iLQZtNsL/upHpUk6ZKGqTgxGIEARKb
         6VYe+pqvh1X2FEf8DrXUaceY11K0mvWKyiPDLdf5LCuF44jE/tgcbWfc7uHuHw1KvUMd
         d4xenaR1lZgq/VU2MiFcElTaXy3BcDUXV1LlU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=j4ubOaV3A6Lhk69mBJL8aXvI5oHdRFkSJ8adq8lc0hW2+oNyXjpgI2aeycaE0A5Th9
         C5bdlAo00Vl+oX7IyPcWnf1nwOags3y7cr6SxeSZaGKOFeDmUCO+MGWP7/bL5AA+vtIk
         Ho+0fOWd3AJ5A51FsoMu78pcz/TibS1PKa9a8=
Received: by 10.141.163.12 with SMTP id q12mr7656317rvo.265.1225568561033;
        Sat, 01 Nov 2008 12:42:41 -0700 (PDT)
Received: by 10.141.163.16 with HTTP; Sat, 1 Nov 2008 12:42:40 -0700 (PDT)
In-Reply-To: <vpqmygmw1mr.fsf@bauges.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99764>

Hi,

On Thu, Oct 30, 2008 at 9:20 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Theodore Tso <tytso@mit.edu> writes:
>
>> * Add the command "git revert-file <files>" which is syntactic sugar for:
>>
>>         git checkout HEAD -- <files>
>
> I don't think "revert-file" is a good name for this: although other
> SCM often call this "revert", what Git calls "revert" is about
> reverting an existing commit (it's "backout" in hg for example). The
> terminology to revert the working tree to the last commited version is
> already here in Git, it's "reset".

git's reset is _not_ the same as svn/bzr/hg's revert; and it's overlap
in functionality is smaller than you realize.

> I've already argued in favor of allowing "git reset --hard <files>",
> which is consistant with existing terminology and doesn't add an extra
> command, but without success.

Such a command would
  * delete newly added files instead of simply untracking them.
That's the right thing for reset, but not for a svn/bzr/hg-like revert
(and unfortunately means unintended data loss.)
  * doesn't make sense during an incomplete merge, unless you add some
way of specifying which branch users want to revert their files back
to.  Aren't there enough confusing flags for reset already?  (One
surprisingly common comment I get about eg is that git reset is too
hard to understand and eg reset fixes it -- despite the fact that I
merely renamed two flags and hid the second form of the command.)
  * doesn't work for the initial commit
  * provides no way to revert files or subdirectories back to their
state at some previous revision (hg and bzr revert have a flag to
provide this; it's not useful all the time but is on occasion)  Also,
if users try to modify their command slightly to get such behavior,
say 'git reset --hard REVISION' instead of 'git reset --hard .', then
they're in trouble.  (Recoverable, but they need an 'expert' to help
them now.)


Also, there's three different kinds of "undo": switching to an old
revision (git checkout REVISION, or svn/hg update -r, etc.),
forgetting or discarding commits/merges/rebases (git reset), and
modifying files to undo previous modifications without touching HEAD
(svn/bzr/hg revert).  Users get confused enough between these
different kinds of undo; overloading them further would be really bad,
IMO.

(Part of the reason for users getting confused between these kinds of
undo is the fact that git doesn't implemented svn/bzr/hg-like revert,
and tends to steer them towards git checkout and git reset, which are
commands typically meant for the *other* kinds of undo.)


Just my $0.02,
Elijah
