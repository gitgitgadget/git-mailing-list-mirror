From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC] contrib: add win32 credential-helper
Date: Wed, 4 Apr 2012 12:37:25 +0200
Message-ID: <CABPQNSYRxZHSW_urpH7yh=Bct2-X2TAsd3=jaJF_9Rb-foegLA@mail.gmail.com>
References: <1332198414-5884-1-git-send-email-kusmabite@gmail.com>
 <20120323211001.GA18198@sigill.intra.peff.net> <CABPQNSac0opcTDVBwr4VeuA7pxqbtsqU7mdmYWms9tu3MjcpeQ@mail.gmail.com>
 <20120404101014.GB13870@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 04 12:38:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFNbT-00029L-NL
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 12:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756074Ab2DDKiI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Apr 2012 06:38:08 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57494 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755789Ab2DDKiH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Apr 2012 06:38:07 -0400
Received: by pbcun15 with SMTP id un15so147339pbc.19
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 03:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=9dVr57Ceo2k05B+8VKOpiLCV/KHqxxZ2smHob7PXUv8=;
        b=W4rrdhLplsCDrf3HLfGGGOOoGWlDiFjbCqAI+XEx9cxLUTFka6rVW5IaL8K4+Jcrww
         bRD5G7bcWZ0dYyPoU58+yfRA6cljEkSPFgGg3jtZFvgSiXETiGtQlDis73seavt1f8Oh
         c/dK9bhlwyGQ+VS3LHhpabTuWxKTM6RNaRelqNKXAUJsr/KIBKrwICxL3EXLI3eLmy1g
         QKDNj2VTuIZbsPUEROfqpJ2WRQlSbuZ4m2b/I0Y7+ckvtMZbVMeI/h0JgUIKc9ocEotb
         yw+pTt2sxZGUlocchP7a/97ddlnUJtYrJQxxq9k3ywpIuEnaPa6YkgXmeceXIIGgGqTJ
         p9DA==
Received: by 10.68.221.40 with SMTP id qb8mr36169775pbc.154.1333535886719;
 Wed, 04 Apr 2012 03:38:06 -0700 (PDT)
Received: by 10.68.136.40 with HTTP; Wed, 4 Apr 2012 03:37:25 -0700 (PDT)
In-Reply-To: <20120404101014.GB13870@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194692>

On Wed, Apr 4, 2012 at 12:10 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Apr 02, 2012 at 05:53:47PM +0200, Erik Faye-Lund wrote:
>
>> > Otherwise, newline is a reasonable choice, as the protocol
>> > already can't communicate usernames/passwords with newlines (a
>> > limitation that I accepted to make the protocol much simpler for
>> > scripting use).
>>
>> This works, but it causes Windows 7's credential manager to glitch i=
n
>> rendering the credential (adding all the newlines to the end of the
>> line, and stretching an icon - yuck), which is also a bit unfortunat=
e.
>>
>> So I'm thinking that escaping the string needs to be done. It can't =
be
>> that big of a deal ;)
>
> Gross. I guess backslash-escaping or something similar would be prett=
y
> easy to implement.
>

As I said in a follow-up mail; Windows' credential stuff has a
general-purpose application-defined data-store. I can use that
instead, it turns out.

>> > Like many other parts of git, we treat the data as binary goo as m=
uch as
>> > possible. So git hands the helper whatever bytes the user provided=
, and
>> > ships off whatever bytes are provided by the helper over http with=
out
>> > any further processing. The only two exceptions are:
>> [...]
>>
>> ASCII unsernames might be common in the UNIX-world, but in the Windo=
ws
>> world this is very much not the case. These functions can be used fo=
r
>> all kinds of services, so I don't think assuming ASCII makes much
>> sense.
>>
>> And since OSX documents the encoding, I'm guessing that non-ASCII
>> usernames isn't entirely unheard of there either.
>
> But what does it mean to have an encoding for credentials that will b=
e
> sent over http basic-auth? As far as I know, the binary bytes are sim=
ply
> base64-encoded and sent to the server in a header, and there is no ro=
om
> for an encoding or any normalization in the password. You just hope t=
hat
> the remote side is using the same encoding as you, and that there are=
 no
> normalization issues (e.g., your username contains "e with accent", b=
ut
> your input system provides "e" + "combining accent").
>
> It looks like there is a draft rfc to try to help with this:
>
> =A0http://tools.ietf.org/html/draft-reschke-basicauth-enc-05
>
> but I have no idea if it is adopted at all yet.
>

Sure, but this is a problem with HTTP-auth, we don't have to make it a
problem of our credential-api as well. For instance,  we could try to
send the credentials to the server as UTF-8 first, and if that fails
re-try with ISO-8859-1. If neither works, we probably need more info;
if it's worth it somebody could implement a per-remote locale or
something. I'm not saying we should, but it's something that could be
done if the HTTP-auth issue proves to be real.

Losing the encoding EARLY isn't any better than trying to preserve it
for as long as possible, and only lose it when we KNOW we're sending
this down a path where the encoding is undefined? And passing UTF-8
data when the encoding is undefined is probably one of the less insane
things to attempt, no?

>> In general, I think the whole "let's try to get away with not
>> specifying encoding" is a bit dangerous. Without knowing what encodi=
ng
>> the input and output is, the helpers are pretty much useless for
>> people.
>
> Not necessarily. By being a pass-through, things will usually just wo=
rk.
> That is, if you hand the helper UTF-8 to store, then it should hand y=
ou
> back UTF-8. Ditto for any other encoding. And if it doesn't work, it'=
s
> not the helper's problem, but a mismatch between the http client and
> server. The helper's job is to reproduce some bytes.
>

The problem is that for some helpers you need to know the encoding in
order to have a user-interface show the data. This goes both for OSX
and Windows. If you mess up the encoding, in the helper, then you'll
mess up the entries in the OS'es key-managers. While this might not be
a problem in practice for US-English users, we've seen for Git for
Windows that e.g. some Asians are really unhappy with their username
becoming some completely incomprehensible string.

Saying "Hey, I'm just passing on what I got here, don't blame the
messenger" isn't a solution, it's adding to the problem. I'm sorry if
I'm a bit blunt here, but being a pass-through is a sorry excuse. User
names and passwords are text-strings by definition; "name" and "word"
both imply it. No one has a binary blob of 0xbadf00d as a username or
password.

Now, my suggestion was to define that these are UTF-8; if we pass it
UTF-8 it will still give back UTF-8. But it can be converted
internally so the OS can show the credential in it's manager.

>> Sure, saying "at least ASCII" helps, but it just takes us
>> halfway there. And, I think UTF-8 is the least insane option here.
>
> Of course. UTF-8 is pretty much always the least insane option, and I
> would hope that everybody is using it. But by being a pass-through, w=
e
> don't restrict it. If the client and server both want to use Shift JI=
S,
> then the stock git helpers will work fine. On systems where the OS
> mandates a particular encoding (I didn't even check for the OS X help=
er,
> but let us imagine it will barf on non-UTF8 data), then I would expec=
t
> everybody to be using that encoding, and the pass-through just works.
>
> If your helper storage really cares, then I think it's sane to assume
> you'll get UTF-8 input, and to pass that back out.

UTF-8-by-convention is just pretending the issue wasn't there; why
can't we simply fix it? I really don't think we should actively try to
inherit HTTP-auth's problems...

> But I really didn't
> want to open the can of worms that is having "getpass()" figure out w=
hat
> encoding it is getting from the user.

What can of worms? Shouldn't getpass simply get the password in the
current system locale? When the user inputs the string is exactly the
moment we want to convert the "external locale" into a known encoding.
